import 'package:biblosphere/src/app/tab_page.dart';
import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(secondary: AppColors.accent1),
        scaffoldBackgroundColor: AppColors.white,
        dividerTheme: const DividerThemeData(
          color: AppColors.greyMiddle,
          thickness: 1,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.accent1,
        ),
      ),
      home: const TabPage(),
    );
  }
}
