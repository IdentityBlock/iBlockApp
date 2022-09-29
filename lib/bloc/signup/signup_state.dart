part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}

class Initial extends SignupState {}

class Submitted extends SignupState {}

class Success extends SignupState {}

class Failed extends SignupState {
  String message;
  Failed(this.message);
}