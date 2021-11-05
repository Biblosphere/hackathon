import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum AppIcons {
  camera,
  close,
  dislike,
  geo,
  heartDislike,
  heartLike,
  like,
  logoText,
  logo,
  menu,
  thunder,
  trash,
}

extension _AppIconsPath on AppIcons {
  static const iconsPath = 'assets/icons';

  String get path {
    switch (this) {
      case AppIcons.camera:
        return '$iconsPath/camera.svg';
      case AppIcons.close:
        return '$iconsPath/close.svg';
      case AppIcons.dislike:
        return '$iconsPath/dislike.svg';
      case AppIcons.geo:
        return '$iconsPath/geo.svg';
      case AppIcons.heartDislike:
        return '$iconsPath/heart_dislike.svg';
      case AppIcons.heartLike:
        return '$iconsPath/heart_like.svg';
      case AppIcons.like:
        return '$iconsPath/like.svg';
      case AppIcons.logoText:
        return '$iconsPath/logo_text.svg';
      case AppIcons.logo:
        return '$iconsPath/logo.svg';
      case AppIcons.menu:
        return '$iconsPath/menu.svg';
      case AppIcons.thunder:
        return '$iconsPath/thunder.svg';
      case AppIcons.trash:
        return '$iconsPath/trash.svg';
    }
  }
}

class AppIcon extends StatelessWidget {
  const AppIcon(
    this.icon, {
    Key? key,
    this.fit = BoxFit.contain,
    this.height,
    this.width,
    this.color,
  }) : super(key: key);

  final AppIcons icon;
  final BoxFit fit;
  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon.path,
      fit: fit,
      height: height,
      width: width,
      color: color,
    );
  }
}
