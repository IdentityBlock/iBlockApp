import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class Accounts{
  static List<Account> accounts = [];

  static const String _rpcUrl = "http://192.168.8.163:7546";
  static const String _wsUrl = "ws://192.168.8.163:7546";

  static const String _privateKey = "7e9d236e0613b719e287e25874a4ea9a971f1855c02906affa1348818a4d7bf5";

  static late Web3Client _client;
  static late var _abiCode;

  static late EthereumAddress _contractAddress;
  static late EthereumAddress _ownAddress;

  static late Credentials _credentials;

  static late DeployedContract _contract;

  static late ContractFunction _addAccount;


  static Future<void> getAbi() async {
    String abiStringFile = await rootBundle.loadString("contracts/build/contracts/Accounts.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi['abi']);
    // _contractAddress = EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    // print(_contractAddress);
    _contractAddress = EthereumAddress.fromHex("0x094Bb70b8F5f73E8919Cb41cb4b9f852Da2E4cf2");
  }

  static Future<void> getCredentials () async {
    _credentials = await EthPrivateKey.fromHex(_privateKey);
    _ownAddress = await _credentials.extractAddress();
  }

  static Future<void> getDeployedContract() async{
    _contract = DeployedContract(ContractAbi.fromJson(_abiCode, "Accounts"), _contractAddress);
    _addAccount = _contract.function("addAccount");
  }

  static Future<String> createAccount(
      String name,
      String email
      ) async {
    _client = Web3Client(_rpcUrl, Client(), socketConnector: (){
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });
    await getAbi();
    await getCredentials();
    await getDeployedContract();
    var result = await _client.sendTransaction(
      _credentials,
      Transaction.callContract(contract: _contract, function: _addAccount, parameters: [name, email])
    ).timeout(const Duration(seconds: 10), onTimeout: throw Exception("Request timed out!"));

    return result.toString();
  }
}

class Account{
  String name;
  String email;
  Account({required this.name, required this.email});
}