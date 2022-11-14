part of 'initialize_bloc.dart';

@immutable
abstract class InitializeEvent {}

class InitializeAppEvent extends InitializeEvent {}

class CheckInternetConnection extends InitializeEvent{}

class AuthenticateEvent extends InitializeEvent{}

class CheckStatus extends InitializeEvent{}