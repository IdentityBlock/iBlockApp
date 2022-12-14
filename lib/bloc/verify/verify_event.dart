part of 'verify_bloc.dart';

@immutable
abstract class VerifyEvent {}

class QRDetectedEvent extends VerifyEvent{
  final Barcode qrCode;
  QRDetectedEvent(this.qrCode);
}
class Verify extends VerifyEvent{
  final String verifierName;
  final String verifierContract;
  final String token;

  Verify(this.verifierName, this.verifierContract, this.token);
}
