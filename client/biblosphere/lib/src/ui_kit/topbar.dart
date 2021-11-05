import 'dart:io';

import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:biblosphere/src/ui_kit/logo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _kTopbarMobileHeight = 60.0;
const _kTopbarWebHeight = 140.0;
const _kElevation = 0.0;
const _kAutomaticallyImplyLeading = false;
const _kBackgroundColor = AppColors.white;
const _kSystemOverlayStyle = SystemUiOverlayStyle(
  statusBarBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.dark,
  statusBarColor: kIsWeb ? null : AppColors.transparent,
);
const _kCenterTitle = true;

class AppTopBar extends AppBar {
  AppTopBar({Key? key})
      : super(
          key: key,
          elevation: _kElevation,
          automaticallyImplyLeading: _kAutomaticallyImplyLeading,
          systemOverlayStyle: _kSystemOverlayStyle,
          backgroundColor: _kBackgroundColor,
          centerTitle: _kCenterTitle,
          title: const AppLogo(),
        );

  @override
  Size get preferredSize => Size.fromHeight(
        Platform.isAndroid || Platform.isIOS
            ? _kTopbarMobileHeight
            : _kTopbarWebHeight,
      );
}

class AppSliverTopBar extends SliverAppBar {
  AppSliverTopBar({Key? key, VoidCallback? onTap})
      : super(
          key: key,
          elevation: _kElevation,
          automaticallyImplyLeading: _kAutomaticallyImplyLeading,
          systemOverlayStyle: _kSystemOverlayStyle,
          backgroundColor: _kBackgroundColor,
          centerTitle: _kCenterTitle,
          title: onTap != null
              ? GestureDetector(onTap: onTap, child: const AppLogo())
              : const AppLogo(),
        );
}
