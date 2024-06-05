import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ravenpay_assessment/core/theme/app_themes.dart';
import 'package:ravenpay_assessment/core/theme/bloc/theme/theme_bloc.dart';


void main() {
  late ThemeBloc themeBloc;

  setUp(() {
    themeBloc = ThemeBloc();
  });

  tearDown(() {
    themeBloc.close();
  });

  test('initial state is ThemeState with light theme', () {
    expect(themeBloc.state, ThemeState(themeData: appThemeData[AppTheme.lightTheme]!));
  });

  blocTest<ThemeBloc, ThemeState>(
    'emits ThemeState with dark theme when ThemeChanged event is added',
    build: () => themeBloc,
    act: (bloc) => bloc.add(ThemeChanged(theme: AppTheme.darkTheme)),
    expect: () => [ThemeState(themeData: appThemeData[AppTheme.darkTheme]!)],
  );
}
