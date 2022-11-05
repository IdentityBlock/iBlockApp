import 'dart:convert';

import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class UserContractService{

  late final Object _abiJSON;

  UserContractService() {
    _abiJSON = _getAbi();
  }

  Future<String> deploy(String ethAddress, {
    required String name,
    required String email,
    required String dob,
    required String country,
    required String mobile,
    required String gender
  }) async{
    // return the address of deployed contract
    final response = await http.post(Uri.parse("${Config.backendUrl}/contract"),
                        body: {
                          "ethaddress" : ethAddress,
                          "name": name,
                          "email": email,
                          "dob": dob,
                          "country": country,
                          "mobile": mobile,
                          "gender": gender
                        });

    if(response.statusCode == 200){
      var responseJson = jsonDecode(response.body);
      return responseJson['contract-address'];
    }
    else{
      throw Exception("Unable to connect to the backend");
    }
  }

  Future<Object> _getAbi() async{
    // get the abi from calling the application backend
    final response = await http.get(Uri.parse("${Config.backendUrl}/contract"));
    if(response.statusCode == 200){
      var responseJson = jsonDecode(response.body);
      return responseJson['data'];
    }
    else{
      throw Exception("Unable to connect to the backend");
    }
  }

  Future<String> getName(String contractAddress, String privateKey) async{
    EthereumAddress contract = EthereumAddress.fromHex(contractAddress);
    EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
    EthereumAddress sender = await credentials.extractAddress();

    Object abi = await _abiJSON;

    DeployedContract smartContract = DeployedContract(ContractAbi.fromJson(jsonEncode(abi), "User"), contract);

    ContractFunction _getName = smartContract.function("getName");

    Web3Client web3client = Web3Client(Config.rpcUrl, http.Client(), socketConnector: (){
      return IOWebSocketChannel.connect(Config.wsUrl).cast<String>();
    });

    var result = await web3client.call(contract: smartContract, function: _getName, params: [], sender: sender);

    web3client.dispose();
    return result[0] as String;
  }

  Object getAbiJson() {
    return _abiJSON;
  }
}