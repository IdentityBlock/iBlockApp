import 'dart:developer';

import 'package:iblock/services/user_contract_service.dart';
import 'package:test/test.dart';

// NOTE: given addresses here are from local ganache blockchain server.
void main(){
  test('Testing for abi file', () async{
    final service = UserContractService();
    Object abi = await service.getAbi();
    log(abi.toString());
  });
  
  test('Testing deployment of user contract', () async{
    final service = UserContractService();
    var result = await service.deploy(name: "test", email: "test@example.com", dob: "2000/01/01", country: "Sri Lanka", mobile: "+9412345678", gender: "Male");

    log(result.toString());
  });
  
  test('Test fetching details from user contract: called by owner', () async{
    final service = UserContractService();
    var result = await service.getAll("0x547fda582EeEc9574BFF8Aa768786C15702AE0fD",
        "0xdb7a1fc3433dbe9d11b53357927dbfc80e3f9d5c211c6c29ce49acca3633dbf3");
    log(result.toString());
    expect(result, {"Name": "test", "Email": "test@example.com", "Date of Birth": "2000/01/01", "Country": "Sri Lanka", "Phone": "+9412345678", "Gender": "Male"});
  });

  test('Test fetching details from user contract: called by other', () async{
    final service = UserContractService();
    
    expect(service.getAll("0x949e1fB80027B3D9b7D33767A17a2B4ebfD1Cb73",
        "2ffdcdececb76f1c6ff826cbb4c0138cac3f5f2950540a1ff1a0530cd5f5063f"), throwsException);
  });

  test('Test Setting Name: by the owner', () async{
    final service = UserContractService();
    await service.setName("test3", privateKey: "0xdb7a1fc3433dbe9d11b53357927dbfc80e3f9d5c211c6c29ce49acca3633dbf3", contractAddress: "0x547fda582EeEc9574BFF8Aa768786C15702AE0fD");

    var result = await service.getAll("0x547fda582EeEc9574BFF8Aa768786C15702AE0fD",
        "0xdb7a1fc3433dbe9d11b53357927dbfc80e3f9d5c211c6c29ce49acca3633dbf3");

    expect(result, {"Name": "test3", "Email": "test@example.com", "Date of Birth": "2000/01/01", "Country": "Sri Lanka", "Phone": "+9412345678", "Gender": "Male"});

  });
  
  test('Testing verify function', () async{
    final service = UserContractService();
    String transactionId = await service.verify("0xf32cfe97272a46291BF81f85dBb01797f0249635", "123456",  privateKey: "0xaf116e5a7fe877b8882ad736395d0371a4f5e822160f16d57e285dfe9132e5b6", contractAddress: "0x9b03DB9C86BE02628558D45356E2220f16BCB6c9");
    log(transactionId);
    expect(transactionId, startsWith("0x"));
  });

  group('User contract functons', (){
    final service = UserContractService();
    late final String privateKey;
    late final String contractAddress;
    test('Testing deployment of user contract', () async{

      var result = await service.deploy(name: "user1", email: "user1@iblock.com", dob: "2000/01/01", country: "Sri Lanka", mobile: "+9412345678", gender: "Male");

      log(result.toString());
      privateKey = result['private-key'] as String;
      contractAddress = result['contract-address'] as String;
    });

    test('Test fetching details from user contra ct: called by owner', () async{
      final service = UserContractService();
      var result = await service.getAll(contractAddress, privateKey);
      log(result.toString());
      expect(result, {"Name": "user1", "Email": "user1@iblock.com", "Date of Birth": "2000/01/01", "Country": "Sri Lanka", "Phone": "+9412345678", "Gender": "Male"});
    });

    test('Test Setting Name: by the owner', () async{
      final service = UserContractService();
      await service.setName("user2", contractAddress: contractAddress, privateKey: privateKey);
      await service.setEmail("user2@iblock.com", contractAddress: contractAddress, privateKey: privateKey);
      await service.setCountry("India", contractAddress: contractAddress, privateKey: privateKey);
      await service.setGender("Female", contractAddress: contractAddress, privateKey: privateKey);
      await service.setMobile("+123456789", contractAddress: contractAddress, privateKey: privateKey);


      var result = await service.getAll(contractAddress, privateKey);

      expect(result, {"Name": "user2", "Email": "user2@iblock.com", "Date of Birth": "2000/01/01", "Country": "India", "Phone": "+123456789", "Gender": "Female"});

    });

    test('Testing verify function', () async{
      final service = UserContractService();
      String transactionId = await service.verify("0x1Ff8Ebe435cdD925EE58388c78a6b21f650247B6", "12345",  privateKey: privateKey, contractAddress: contractAddress);
      expect(transactionId, startsWith("0x"));
    });
  });
}