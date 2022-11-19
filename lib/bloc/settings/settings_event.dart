part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class LoadEvent extends SettingsEvent{}

class LoadHistoryEvent extends SettingsEvent{}

class EditEvent extends SettingsEvent{
  final String editedProperty;
  final String privateKey;
  final String contractAddress;
  final String email;
  final String phone;
  EditEvent(this.editedProperty, {required this.privateKey, required this.contractAddress, required this.email, required this.phone});
}

class VerifyEmail extends SettingsEvent{}