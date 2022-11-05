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
    String contractaddress = await service.deploy("0xb2380fD3872B692BbD16980B45E199FD00AE332A",
        name: "test", email: "test@example.com", dob: "2000/01/01", country: "Sri Lanka", mobile: "+9412345678", gender: "Male");

    print(contractaddress);
  });
  
  test('Test fetching details from user contract: called by owner', () async{
    final service = UserContractService();
    var result = await service.getAll("0x949e1fB80027B3D9b7D33767A17a2B4ebfD1Cb73",
        "c2dc617baba8793774026d6b2559f45a5fd4c856fdbccc55fc2cbf4fbec1808f");
    print(result);
    expect(result, {"Name": "Akila", "Email": "akila.19@cse.mrt.ac.lk", "Date of Birth": "1999/01/01", "Country": "Sri Lanka", "Phone": "+941234567", "Gender": "Male"});
  });

  test('Test fetching details from user contract: called by other', () async{
    final service = UserContractService();
    
    expect(service.getAll("0x949e1fB80027B3D9b7D33767A17a2B4ebfD1Cb73",
        "2ffdcdececb76f1c6ff826cbb4c0138cac3f5f2950540a1ff1a0530cd5f5063f"), throwsException);
  });
}