import 'package:biblosphere/src/app/input_page/input_page.dart';
import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: AppColors.accent1,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.white,
        dividerTheme: const DividerThemeData(
          color: AppColors.greyMiddle,
          thickness: 1,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.accent1,
        ),
      ),
      home: const InputPage(),
    );
  }
}
