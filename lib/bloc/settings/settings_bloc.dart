import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../services/history_logging_service.dart';
import '../../services/secure_storage_service.dart';
import '../../services/user_contract_service.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(Initial()) {
    on<LoadEvent>((event, emit) async {
      emit(Loading());

      try {
        var privateKey =
            await SecureStorageService.get("private-key") as String;
        var contractAddress =
            await SecureStorageService.get("contract-address") as String;

        var service = UserContractService();
        var userInfo = await service.getAll(contractAddress, privateKey).timeout(const Duration(seconds: 10), onTimeout: (){
          throw Exception("Timeout");
        });
        emit(Loaded(
            privateKey: privateKey,
            contractAddress: contractAddress,
            email: userInfo['Email'] as String,
            phone: userInfo['Phone'] as String));
      } catch (e) {
        emit(Failed(e.toString()));
      }
    });

    on<EditEvent>((event, emit) async {
      emit(Loading());
      try {
        var service = UserContractService();
        if (event.editedProperty == "email") {
          await service.setEmail(event.email,
              contractAddress: event.contractAddress,
              privateKey: event.privateKey);
        } else if (event.editedProperty == "phone") {
          await service.setMobile(event.phone,
              contractAddress: event.contractAddress,
              privateKey: event.privateKey);
        }
        else{
          throw Exception("Unexpected Error");
        }
        emit(Loaded(privateKey: event.privateKey, contractAddress: event.contractAddress, email: event.email, phone: event.phone));
      }
      catch(e){
        emit(Failed(e.toString()));
      }
    });
  }
}
