part of 'initialize_bloc.dart';

@immutable
abstract class InitializeEvent {}

class InitializeAppEvent extends InitializeEvent {}

class CheckInternetConnection extends InitializeEvent{}

class AuthenticateEvent extends InitializeEvent{}

class CheckStatus extends InitializeEvent{}

class LoadUserInfoEvent extends InitializeEvent{}

class SetUserInfoEvent extends InitializeEvent{
  final Map<String, String> userInfo;
  SetUserInfoEvent(this.userInfo);
}