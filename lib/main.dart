import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promilo/cubits/app_bar_title_cubit.dart';
import 'package:promilo/screens/login_screen.dart';
import 'package:promilo/utils/theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ),
  );
  runApp(const MyApp());
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppBarTitleCubit(),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
          title: 'Promilo',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.light,
          theme: AppTheme.lightTheme,
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: MyBehavior(),
              child: child!,
            );
          },
          home: const LoginScreen(),
        ),
      ),
    );
  }
}
