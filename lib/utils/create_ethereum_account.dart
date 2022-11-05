
// generate ethereum account
// generate ethereum private key and transfer some funds for do the storing account information transaction

import 'dart:math'; //used for the random number generator

import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

import '../config.dart';

class CreateEthereumAccount{

  static final _httpClient = Client();
  static final _ethClient = Web3Client(Config.rpcUrl, _httpClient);

  // create a private key
  static Credentials _genratePrivateKey() {
    var seed = Random.secure();
    Credentials privateKey = EthPrivateKey.createRandom(seed);
    return privateKey;
  }

  // transfer some ether to the account created
  static Future<String> _transactEther(EthereumAddress recieverAddress) async{
    EthPrivateKey fundingTransferingPrivateKey = EthPrivateKey.fromHex(Config.fundTransferAccountPrivateKey);
    Transaction transaction = Transaction(to: recieverAddress, value: EtherAmount.inWei(BigInt.from(pow(10, 18))));
    String result = await _ethClient.sendTransaction(fundingTransferingPrivateKey, transaction);

    return result;
  }

  // return a new private key with some funds on it
  static Future<String> create() async{
    EthPrivateKey newPrivateKey = _genratePrivateKey() as EthPrivateKey;
    EthereumAddress address = await newPrivateKey.extractAddress();
    await _transactEther(address);

    return  bytesToHex(newPrivateKey.privateKey);
  }

  static Future<String> getEthereumAddress(String privateKey) async{
    EthPrivateKey newPrivateKey = EthPrivateKey.fromHex(privateKey);
    EthereumAddress address = await newPrivateKey.extractAddress();
    return address.hex;
  }

}