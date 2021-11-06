import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum UIIcons {
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

extension _UIIconsPath on UIIcons {
  static const iconsPath = 'assets/icons';

  String get path {
    switch (this) {
      case UIIcons.camera:
        return '$iconsPath/camera.svg';
      case UIIcons.close:
        return '$iconsPath/close.svg';
      case UIIcons.dislike:
        return '$iconsPath/dislike.svg';
      case UIIcons.geo:
        return '$iconsPath/geo.svg';
      case UIIcons.heartDislike:
        return '$iconsPath/heart_dislike.svg';
      case UIIcons.heartLike:
        return '$iconsPath/heart_like.svg';
      case UIIcons.like:
        return '$iconsPath/like.svg';
      case UIIcons.logoText:
        return '$iconsPath/logo_text.svg';
      case UIIcons.logo:
        return '$iconsPath/logo.svg';
      case UIIcons.menu:
        return '$iconsPath/menu.svg';
      case UIIcons.thunder:
        return '$iconsPath/thunder.svg';
      case UIIcons.trash:
        return '$iconsPath/trash.svg';
    }
  }
}

class UIIcon extends StatelessWidget {
  const UIIcon(
    this.icon, {
    Key? key,
    this.fit = BoxFit.contain,
    this.height,
    this.width,
    this.color,
  }) : super(key: key);

  final UIIcons icon;
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
