import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:konsuldoc/core/constants/hive_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_state_provider.g.dart';

@riverpod
class ThemeState extends _$ThemeState {
  final _box = Hive.box(HiveConstants.box);

  @override
  ThemeMode build() {
    final isDarkMode = _box.get(HiveConstants.isDarkMode, defaultValue: false);

    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  void toggle() {
    final isDarkMode = state == ThemeMode.light;
    _box.put(HiveConstants.isDarkMode, isDarkMode);
    state = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }
}
