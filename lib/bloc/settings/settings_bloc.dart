import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(Initial()) {
    on<LoadEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<EditEmail>((event, emit){

    });

    on<VerifyEmail>((event,emit){

    });
  }
}
