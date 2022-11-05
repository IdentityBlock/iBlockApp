part of 'initialize_bloc.dart';

@immutable
abstract class InitializeState {}

class Initial extends InitializeState {}

class CheckingInternetConnection extends InitializeState{}

class NoInternetConnection extends InitializeState{}

class Registered extends InitializeState {
  final Map<String, String> userInfo;
  Registered(this.userInfo);
}

class NotRegistered extends InitializeState {}

class InitializeError extends InitializeState{
  String message;
  InitializeError(this.message);
}
