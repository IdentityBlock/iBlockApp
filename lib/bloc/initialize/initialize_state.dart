part of 'initialize_bloc.dart';

@immutable
abstract class InitializeState {}

class Initial extends InitializeState {}

class CheckingInternetConnection extends InitializeState{}

class Authenticating extends InitializeState{}

class Authenticated extends InitializeState{}

class NoInternetConnection extends InitializeState{}

class Registered extends InitializeState {
  final Map<String, String> userInfo;
  Registered(this.userInfo);
}

class PartiallyRegistered extends InitializeState{}

class NotRegistered extends InitializeState {}

class Failed extends InitializeState{
  final String message;
  Failed(this.message);
}
