import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'initialize_event.dart';
part 'initialize_state.dart';

class InitializeBloc extends Bloc<InitializeEvent, InitializeState> {
  InitializeBloc() : super(Initial()) {
    on<InitializeAppEvent>((event, emit) async{
      emit(Initial());
      await Future.delayed(const Duration(seconds: 3));

      emit(CheckingInternetConnection());
      await Future.delayed(const Duration(seconds: 3));

      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        emit(NotRegistered());
      }
      else{
        emit(NoInternetConnection());
      }

    });
  }
}
