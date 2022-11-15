part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class LoadEvent extends SettingsEvent{}

class EditEmail extends SettingsEvent{
  final String newEmail;
  EditEmail(this.newEmail);
}

class VerifyEmail extends SettingsEvent{}

class EditPhone extends SettingsEvent{
  final String newPhone;
  EditPhone(this.newPhone);
}