import 'package:flutter/material.dart';

abstract class UIStyles {
  static TextStyle defaultRegularHeadline({Color? color}) => TextStyle(
        fontSize: 17,
        height: 22 / 17,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
        color: color,
      );

  static TextStyle defaultRegularBody({Color? color}) => TextStyle(
        fontSize: 17,
        height: 22 / 17,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.01,
        color: color,
      );

  static TextStyle defaultRegularComment({Color? color}) => TextStyle(
        fontSize: 14,
        height: 22 / 14,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.01,
        color: color,
      );

  static TextStyle cameraButton({Color? color}) => TextStyle(
        fontSize: 18,
        height: 21 / 18,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.3,
        color: color,
      );

  static TextStyle defaultRegularTitle1({Color? color}) => TextStyle(
        fontSize: 26,
        height: 34 / 26,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.36,
        color: color,
      );
}
