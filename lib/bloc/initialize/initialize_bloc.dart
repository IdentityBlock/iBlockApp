import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:iblock/bloc/settings/settings_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../services/secure_storage_service.dart';
import '../../services/user_contract_service.dart';

part 'initialize_event.dart';
part 'initialize_state.dart';

class InitializeBloc extends Bloc<InitializeEvent, InitializeState> {
  InitializeBloc() : super(Initial()) {
    on<InitializeAppEvent>((event, emit) async{
      emit(Initial());
      //await Future.delayed(const Duration(seconds: 3));

      emit(CheckingInternetConnection());
      add(CheckInternetConnection());
      //await Future.delayed(const Duration(seconds: 3));

    });

    on<CheckInternetConnection>((event, emit) async{
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        add(AuthenticateEvent());
      }
      else{
        emit(NoInternetConnection());
      }
    });

    on<AuthenticateEvent>((event, emit) async{
      emit(Authenticating());
      final LocalAuthentication auth = LocalAuthentication();
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();

      if (! canAuthenticate){
        add(CheckStatus());
      }
      else{
        final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

        if (availableBiometrics.isNotEmpty) {
          try {
            final bool didAuthenticate = await auth.authenticate(
                localizedReason: 'Please authenticate to proceed');
            if(didAuthenticate){
              emit(Authenticated());
              add(CheckStatus());
            }
            else{
              emit(Failed("Failed to Authenticate"));
            }

          } catch(error) {
            log(error.toString());
            emit(Failed("Failed to Authenticate"));
          }
        }
        else{
          add(CheckStatus());
        }
      }

    });

    on<CheckStatus>((event, emit) async{
      bool isPrivateKeyExist = await SecureStorageService.isKeyExist("private-key");
      bool isContractAddressExist = await SecureStorageService.isKeyExist("contract-address");
      if (isPrivateKeyExist && isContractAddressExist){
        var privateKey = await SecureStorageService.get("private-key") as String;
        var contractAddress = await SecureStorageService.get("contract-address") as String;

        try {
          var userInfo = await UserContractService().getAll(
              contractAddress, privateKey).timeout(const Duration(seconds: 10),
              onTimeout: (){
                throw TimeoutException("Unable to fetch data from blockchain!");
              });
          emit(Registered(userInfo));
        }
        catch(e){
          emit(Failed(e.toString()));
        }

      }
      else if(isPrivateKeyExist){
        emit(PartiallyRegistered());
      }
      else{
        emit(NotRegistered());
      }
    });

    on<LoadUserInfoEvent>((event, emit) async{
      emit(Loading());
      try {
        var privateKey = await SecureStorageService.get("private-key") as String;
        var contractAddress = await SecureStorageService.get("contract-address") as String;
        var userInfo = await UserContractService().getAll(
            contractAddress, privateKey).timeout(const Duration(seconds: 10),
            onTimeout: (){
              throw TimeoutException("Unable to fetch data from blockchain!");
            });
        emit(Registered(userInfo));
      }
      catch(e){
        emit(Failed(e.toString()));
      }
    });

    on<SetUserInfoEvent>((event, emit){
      emit(Registered(event.userInfo));
    });
  }
}
