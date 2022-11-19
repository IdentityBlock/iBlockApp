part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class Initial extends SettingsState {}

class Loading extends SettingsState{}

class Loaded extends SettingsState{
  final String privateKey;
  final String contractAddress;
  final String email;
  final String phone;
  Loaded({required this.privateKey, required this.contractAddress, required this.email, required this.phone});
}

class HistoryLoaded extends SettingsState{
  final List<HistoryRecord> records;
  HistoryLoaded(this.records);
}

class Failed extends SettingsState {
  final String message;
  Failed(this.message);
}