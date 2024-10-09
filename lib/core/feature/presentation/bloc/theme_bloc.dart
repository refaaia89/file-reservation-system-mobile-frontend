import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rxdart/rxdart.dart';

class ThemeBloc {
  final BehaviorSubject<ThemeMode> _themeMode = BehaviorSubject.seeded(ThemeMode.system);

  ThemeMode get getThemeModeValue => _themeMode.value;

  Stream<ThemeMode> get getThemeModeStream => _themeMode.stream;

  changeThemeMode({ThemeMode? themeMode}) {
    final ThemeMode theme = themeMode ?? getThemeModeValue;
    switch (theme) {
      case ThemeMode.light:
        _themeMode.sink.add(ThemeMode.dark);
        break;
      case ThemeMode.dark:
        _themeMode.sink.add(ThemeMode.light);
        break;
      case ThemeMode.system:
        if (SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.light) {
          _themeMode.sink.add(ThemeMode.dark);
        } else {
          _themeMode.sink.add(ThemeMode.light);
        }
    }
  }
}
