import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'icons.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.onTap,
    required this.child,
    this.padding,
    this.active = true,
  }) : super(key: key);

  final VoidCallback? onTap;
  final Widget child;
  final EdgeInsets? padding;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kIsWeb ? 72 : 66,
      child: ElevatedButton(
        onPressed: active ? onTap : null,
        child: child,
        style: ButtonStyle(
          alignment: Alignment.center,
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 22, horizontal: 40).copyWith(
              left: padding?.left,
              top: padding?.top,
              right: padding?.right,
              bottom: padding?.bottom,
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
            active ? AppColors.accent1 : AppColors.textDeactive,
          ),
          shadowColor: MaterialStateProperty.all(AppColors.transparent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}

class AppCloseButton extends StatelessWidget {
  const AppCloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: Navigator.of(context).pop,
      child: const AppIcon(
        AppIcons.close,
        height: 24,
        width: 24,
      ),
    );
  }
}
