part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}

class Initial extends SignupState {}

class Loading extends SignupState{}

class Loaded extends SignupState{
  final List<String> countries;
  Loaded(this.countries);
}

class Submitted extends SignupState {}

class Success extends SignupState {
  final Map<String, String> userInfo;
  Success(this.userInfo);
}

class Failed extends SignupState {
  final String message;
  Failed(this.message);
}