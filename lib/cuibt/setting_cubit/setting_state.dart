part of 'setting_cubit.dart';

@immutable
sealed class SettingState {}

final class SettingInitial extends SettingState {}
class SettingThemChange extends SettingState {
  final ThemeData themeData;
  SettingThemChange(this.themeData);
}
