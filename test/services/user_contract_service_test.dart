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
}