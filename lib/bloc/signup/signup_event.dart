part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

class LoadEvent extends SignupEvent{}

class SubmitSignupEvent extends SignupEvent {
  final String name;
  final String email;
  final String dob;
  final String country;
  final String phone;
  final String gender;

  SubmitSignupEvent({
    required this.name,
    required this.email,
    required this.dob,
    required this.country,
    required this.phone,
    required this.gender
  });
}

class RecoverySubmitEvent extends SignupEvent{
  final String privateKey;
  final String contractAddress;

  RecoverySubmitEvent({required this.privateKey, required this.contractAddress});
}