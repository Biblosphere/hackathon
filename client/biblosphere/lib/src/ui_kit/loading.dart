import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({
    Key? key,
    this.size = 10,
    this.width = 2.5,
    this.progress,
  }) : super(key: key);

  final double size;
  final double width;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        value: progress,
        strokeWidth: width,
        valueColor: const AlwaysStoppedAnimation(AppColors.accent1),
      ),
    );
  }
}
