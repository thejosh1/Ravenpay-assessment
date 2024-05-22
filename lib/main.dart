import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ravenpay_assessment/core/res/fonts.dart';
import 'package:ravenpay_assessment/core/theme/bloc/theme/theme_bloc.dart';
import 'package:ravenpay_assessment/src/main_page/presentation/views/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(designSize: const Size(360, 730), minTextAdapt: true,
      splitScreenMode: true, builder: (_, child) {
        return BlocProvider(
          create: (context) => ThemeBloc(),
          child: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                title: 'MyArteLab',
                theme: state.themeData,
                home: const MainPage(),
              );
            },
          ),
        );
      },
    );
  }
}
