import 'dart:convert';
import 'dart:developer';

import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;

import '../config.dart';

class UserContractService{

  Future<Map<String, String>> deploy({
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
                          "name": name,
                          "email": email,
                          "dob": dob,
                          "country": country,
                          "mobile": mobile,
                          "gender": gender
                        });

    if(response.statusCode == 200){
      var responseJson = jsonDecode(response.body);
      return {
        'private-key': responseJson['private-key'],
        'contract-address': responseJson['contract-address']
      };
    }
    else{
      throw Exception("Unable to connect to the backend");
    }
  }

  Future<Object> getAbi() async{
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

  Future<Map<String, String>> getAll(String contractAddress, String privateKey) async{
    EthereumAddress contract = EthereumAddress.fromHex(contractAddress);
    EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
    EthereumAddress sender = await credentials.extractAddress();

    Object abi = await getAbi();

    DeployedContract smartContract = DeployedContract(ContractAbi.fromJson(jsonEncode(abi), "User"), contract);

    ContractFunction getName = smartContract.function("getName");
    ContractFunction getEmail = smartContract.function("getEmail");
    ContractFunction getDOB = smartContract.function("getDOB");
    ContractFunction getMobile = smartContract.function("getMobile");
    ContractFunction getCountry = smartContract.function("getCountry");
    ContractFunction getGender = smartContract.function("getGender");

    Web3Client web3client = Web3Client(Config.rpcUrl, http.Client(), socketConnector: (){
      return IOWebSocketChannel.connect(Config.wsUrl).cast<String>();
    });

    try {
      var name = await web3client.call(contract: smartContract,
          function: getName,
          params: [],
          sender: sender);
      var email = await web3client.call(contract: smartContract,
          function: getEmail,
          params: [],
          sender: sender);
      var dob = await web3client.call(contract: smartContract,
          function: getDOB,
          params: [],
          sender: sender);
      var mobile = await web3client.call(contract: smartContract,
          function: getMobile,
          params: [],
          sender: sender);
      var country = await web3client.call(contract: smartContract,
          function: getCountry,
          params: [],
          sender: sender);
      var gender = await web3client.call(contract: smartContract,
          function: getGender,
          params: [],
          sender: sender);

      return {
        'Name': name[0] as String,
        'Email': email[0] as String,
        'Date of Birth': dob[0] as String,
        'Country': country[0] as String,
        'Phone': mobile[0] as String,
        'Gender': gender[0] as String
      };
    }
    catch(e){
      throw Exception("Non authorized access");
    }
    finally{
      web3client.dispose();
    }
  }

  Future<String> _setUserProperty(String setFunctionName, String newValue, {required String contractAddress, required String privateKey}) async {
    EthereumAddress contract = EthereumAddress.fromHex(contractAddress);
    EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);

    Object abi = await getAbi();

    DeployedContract smartContract = DeployedContract(ContractAbi.fromJson(jsonEncode(abi), "User"), contract);
    ContractFunction setFunction = smartContract.function(setFunctionName);

    Web3Client web3client = Web3Client(Config.rpcUrl, http.Client(), socketConnector: (){
      return IOWebSocketChannel.connect(Config.wsUrl).cast<String>();
    });

    try{
      var transactionId = await web3client.sendTransaction(credentials, Transaction.callContract(contract: smartContract, function: setFunction, parameters: [newValue]));
      return transactionId;
    }
    catch(e){
      throw Exception("Failed due to $e");
    }
    finally{
      web3client.dispose();
    }
  }

  Future<String> setName(String name, {required String contractAddress, required String privateKey}) async{
    return _setUserProperty("setName", name, contractAddress: contractAddress, privateKey: privateKey);
  }

  Future<String> setEmail(String email, {required String contractAddress, required String privateKey}) async{
    return _setUserProperty("setEmail", email, contractAddress: contractAddress, privateKey: privateKey);
  }

  Future<String> setCountry(String country, {required String contractAddress, required String privateKey}) async{
    return _setUserProperty("setCountry", country, contractAddress: contractAddress, privateKey: privateKey);
  }

  Future<String> setMobile(String mobile, {required String contractAddress, required String privateKey}) async{
    return _setUserProperty("setMobile", mobile, contractAddress: contractAddress, privateKey: privateKey);
  }

  Future<String> setGender(String gender, {required String contractAddress, required String privateKey}) async{
    return _setUserProperty("setGender", gender, contractAddress: contractAddress, privateKey: privateKey);
  }

  Future<String> verify(String verifierContractAddress, String token, {required String contractAddress, required String privateKey}) async{
    EthereumAddress contract = EthereumAddress.fromHex(contractAddress);
    EthereumAddress verifierContract = EthereumAddress.fromHex(verifierContractAddress);
    EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
    Object abi = await getAbi();

    DeployedContract smartContract = DeployedContract(ContractAbi.fromJson(jsonEncode(abi), "User"), contract);
    ContractFunction verifyFunction = smartContract.function("verify");

    Web3Client web3client = Web3Client(Config.rpcUrl, http.Client(), socketConnector: (){
      return IOWebSocketChannel.connect(Config.wsUrl).cast<String>();
    });

    var transaction = Transaction.callContract(
        contract: smartContract,
        function: verifyFunction,
        parameters: [verifierContract, contract, token],
    );

    var signedTransaction;
    try{
      signedTransaction = await web3client.signTransaction(credentials, transaction, chainId: Config.chainId);
    }
    catch(e){
      throw Exception("What the hell?");
    }

    var signedString = bytesToHex(signedTransaction);

    log(signedString);

    try{
      final response = await http.get(Uri.parse("${Config.backendUrl}/contract"));
      if(response.statusCode == 200){
        var responseJson = jsonDecode(response.body);
        log(responseJson['txHash']);
        return responseJson['txHash'];
      }
      else{
        throw Exception("Unable to connect to the backend");
      }
    }
    catch(e){
      throw Exception("Failed due to $e");
    }
    finally{
      web3client.dispose();
    }
  }

}