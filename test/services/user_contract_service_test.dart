import 'package:iblock/services/user_contract_service.dart';
import 'package:test/test.dart';

// NOTE: given addresses here are from local ganache blockchain server.
// Since contract address is received via mail can write a automated test.
// Had to use some valid private keys and contract addresses from ganache
void main(){
  test('Testing for abi file', () async{
    final service = UserContractService();
    Object abi = await service.getAbi();
    print(abi.toString());
  });
  
  test('Testing deployment of user contract', () async{
    final service = UserContractService();
    var result = await service.deploy(name: "test", email: "mailer.iblock@gmail.com", dob: "2000/01/01", country: "Sri Lanka", mobile: "+9412345678", gender: "Male");

    print(result.toString());
    expect(result['private-key'], startsWith("0x"));
  });
  
  test('Test fetching details from user contract: called by owner', () async{
    final service = UserContractService();
    var result = await service.getAll("0x9f7fa19Fe3b2df58E1F0a7E0020dDF011a19F608",
        "0xdd2237c254fcd9a0a0c948ef56c71c814687dfbef57bfb173716f9c26437567d");
    print(result.toString());
    expect(result, {"Name": "test", "Email": "mailer.iblock@gmail.com", "Date of Birth": "2000/01/01", "Country": "Sri Lanka", "Phone": "+9412345678", "Gender": "Male"});
  });

  test('Test fetching details from user contract: called by other', () async{
    final service = UserContractService();
    
    expect(service.getAll("0x949e1fB80027B3D9b7D33767A17a2B4ebfD1Cb73",
        "2ffdcdececb76f1c6ff826cbb4c0138cac3f5f2950540a1ff1a0530cd5f5063f"), throwsException);
  });

  test('Test Setting Name: by the owner', () async{
    final service = UserContractService();
    await service.setName("test5", privateKey: "0xdd2237c254fcd9a0a0c948ef56c71c814687dfbef57bfb173716f9c26437567d", contractAddress: "0x9f7fa19Fe3b2df58E1F0a7E0020dDF011a19F608");

    var result = await service.getAll("0x9f7fa19Fe3b2df58E1F0a7E0020dDF011a19F608",
        "0xdd2237c254fcd9a0a0c948ef56c71c814687dfbef57bfb173716f9c26437567d");

    expect(result, {"Name": "test5", "Email": "mailer.iblock@gmail.com", "Date of Birth": "2000/01/01", "Country": "Sri Lanka", "Phone": "+9412345678", "Gender": "Male"});

  });

}