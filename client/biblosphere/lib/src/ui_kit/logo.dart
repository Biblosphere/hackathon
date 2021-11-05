import 'package:biblosphere/src/ui_kit/icons.dart';
import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: const [
        AppIcon(AppIcons.logo),
        SizedBox(width: 21.13),
        AppIcon(AppIcons.logoText),
      ],
    );
  }
}
