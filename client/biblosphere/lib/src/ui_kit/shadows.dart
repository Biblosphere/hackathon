import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:flutter/material.dart';

abstract class AppShadows {
  static final lightTitle = <BoxShadow>[
    BoxShadow(
      color: AppColors.black.withOpacity(0.1),
      offset: const Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: AppColors.black.withOpacity(0.05),
      offset: const Offset(0, -2),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];
}
