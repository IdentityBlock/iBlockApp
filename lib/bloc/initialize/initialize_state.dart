part of 'initialize_bloc.dart';

@immutable
abstract class InitializeState {}

class Initial extends InitializeState {}

class CheckingInternetConnection extends InitializeState{}

class NoInternetConnection extends InitializeState{}

class Registered extends InitializeState {}

class NotRegistered extends InitializeState {}
