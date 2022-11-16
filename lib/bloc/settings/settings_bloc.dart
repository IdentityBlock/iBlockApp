import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../services/secure_storage_service.dart';
import '../../services/user_contract_service.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(Initial()) {
    on<LoadEvent>((event, emit) async {
      emit(Loading());
      var privateKey = await SecureStorageService.get("private-key") as String;
      var contractAddress =
          await SecureStorageService.get("contract-address") as String;

      var service = UserContractService();
      var userInfo = await service.getAll(contractAddress, privateKey);
      emit(Loaded(
          privateKey: privateKey,
          contractAddress: contractAddress,
          email: userInfo['Email'] as String,
          phone: userInfo['Phone'] as String));
    });

    on<EditEmail>((event, emit) {});

    on<VerifyEmail>((event, emit) {});
  }
}
