import 'dart:io';

import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _kTopbarMobileHeight = 60.0;
const _kTopbarWebHeight = 140.0;
const _kElevation = 0.0;
const _kBackgroundColor = AppColors.white;
const _kSystemOverlayStyle = SystemUiOverlayStyle(
  statusBarBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.dark,
  statusBarColor: kIsWeb ? null : AppColors.transparent,
);
final _kLeading = Builder(
  builder: (context) => CupertinoButton(
    onPressed: Navigator.of(context).pop,
    child: const Icon(
      CupertinoIcons.back,
      color: AppColors.accent1,
    ),
  ),
);

class BackButtonAppBar extends AppBar {
  BackButtonAppBar({Key? key})
      : super(
          key: key,
          elevation: _kElevation,
          leading: _kLeading,
          systemOverlayStyle: _kSystemOverlayStyle,
          backgroundColor: _kBackgroundColor,
        );

  @override
  Size get preferredSize => Size.fromHeight(
        Platform.isAndroid || Platform.isIOS
            ? _kTopbarMobileHeight
            : _kTopbarWebHeight,
      );
}

class SliverBackButtonAppBar extends SliverAppBar {
  SliverBackButtonAppBar({
    Key? key,
  }) : super(
          key: key,
          elevation: _kElevation,
          leading: _kLeading,
          systemOverlayStyle: _kSystemOverlayStyle,
          backgroundColor: _kBackgroundColor,
        );
}
