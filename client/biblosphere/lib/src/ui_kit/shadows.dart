import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:flutter/material.dart';

abstract class UIShadows {
  static final lightTitle = <BoxShadow>[
    BoxShadow(
      color: UIColors.black.withOpacity(0.1),
      offset: const Offset(0, 4),
      blurRadius: 12,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: UIColors.black.withOpacity(0.05),
      offset: const Offset(0, -2),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];
}
