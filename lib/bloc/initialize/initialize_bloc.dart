import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'initialize_event.dart';
part 'initialize_state.dart';

class InitializeBloc extends Bloc<InitializeEvent, InitializeState> {
  InitializeBloc() : super(Initial()) {
    on<InitializeAppEvent>((event, emit) async{
      emit(Initial());

      //simulate the initializing tests
      // ex:- check registration status
      await Future.delayed(const Duration(seconds: 3));

      emit(NotRegistered());
    });
  }
}
