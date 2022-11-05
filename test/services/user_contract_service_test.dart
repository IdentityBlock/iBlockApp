import 'package:iblock/services/user_contract_service.dart';
import 'package:test/test.dart';

void main(){
  test('Testing for abi file', () async{
    final service = UserContractService();
    Object abi = await service.getAbiJson();
    print(abi);
  });
  
  test('Testing deployment of user contract', () async{
    final service = UserContractService();
    var result = await service.deploy(name: "test", email: "test@example.com", dob: "2000/01/01", country: "Sri Lanka", mobile: "+9412345678", gender: "Male");

    print(result);
  });
  
  test('Test fetching details from user contract: called by owner', () async{
    final service = UserContractService();
    var result = await service.getAll("0x547fda582EeEc9574BFF8Aa768786C15702AE0fD",
        "0xdb7a1fc3433dbe9d11b53357927dbfc80e3f9d5c211c6c29ce49acca3633dbf3");
    print(result);
    expect(result, {"Name": "test", "Email": "test@example.com", "Date of Birth": "2000/01/01", "Country": "Sri Lanka", "Phone": "+9412345678", "Gender": "Male"});
  });

  test('Test fetching details from user contract: called by other', () async{
    final service = UserContractService();
    
    expect(service.getAll("0x949e1fB80027B3D9b7D33767A17a2B4ebfD1Cb73",
        "2ffdcdececb76f1c6ff826cbb4c0138cac3f5f2950540a1ff1a0530cd5f5063f"), throwsException);
  });
}