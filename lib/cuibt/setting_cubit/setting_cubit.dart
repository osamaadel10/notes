import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:notes/main.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit()
      : super(SettingInitial()) {
    _initializeTheme();
  }

  ThemeData them = ThemeData.light();

  void _initializeTheme() {
    String currentTheme = prefs.getString("them") ?? "dark";
    them = currentTheme == "dark"
        ? ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
          )
        : ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
          );
    emit(SettingThemChange(them));
  }

  void changeTheme() async {
    if (prefs.getString("them") == "dark") {
      await prefs.setString("them", "light");
      them = ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      );
    } else {
      await prefs.setString("them", "dark");
      them = ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      );
    }
    emit(SettingThemChange(them));
  }
}
