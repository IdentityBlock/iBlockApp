import 'package:test/test.dart';

import 'package:iblock/services/user_contract_service.dart';
import 'package:iblock/utils/create_ethereum_account.dart';

void main(){
  test('Check account creation', ()async{
    var privateKey = await CreateEthereumAccount.create();
    print(privateKey);
  });

  test('Check deploying smart contract with account created', () async{
    var privateKey = await CreateEthereumAccount.create();
    var ethereumAddress = await CreateEthereumAccount.getEthereumAddress(privateKey);

    var service = UserContractService();
    service.deploy(ethereumAddress, name: "Mohamed Ishad", email: "ishad@example.com", dob: "1999/09/09", country: "Sri Lanka", mobile: "123456789", gender: "Male");
  });
}