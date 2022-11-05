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
  
  test('Test fetching name from user contract: called by owner', () async{
    final service = UserContractService();
    String result = await service.getName("0x949e1fB80027B3D9b7D33767A17a2B4ebfD1Cb73",
        "c2dc617baba8793774026d6b2559f45a5fd4c856fdbccc55fc2cbf4fbec1808f");
    print(result);
  });
}