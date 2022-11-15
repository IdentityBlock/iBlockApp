part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class Initial extends SettingsState {}

class Loading extends SettingsState{}

class Loaded extends SettingsState{}
