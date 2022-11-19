part of 'verify_bloc.dart';

@immutable
abstract class VerifyState {}

class Initial extends VerifyState {}

class QRDetected extends VerifyState{
  final String verifierName;
  final String verifierContractAddress;
  final String token;
  QRDetected(this.verifierName, this.verifierContractAddress, this.token);
}

class Submitted extends VerifyState{}

class Verified extends VerifyState{
  final String verifier;
  Verified(this.verifier);
}

class Failed extends VerifyState{
  final String message;
  Failed(this.message);
}
