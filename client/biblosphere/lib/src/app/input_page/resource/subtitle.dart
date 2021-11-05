import 'package:biblosphere/src/ui_kit/icons.dart';
import 'package:biblosphere/src/ui_kit/styles.dart';
import 'package:flutter/material.dart';

abstract class _Subtitle extends StatelessWidget {
  const _Subtitle({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 12),
          Text(
            text,
            maxLines: 1,
            style: AppStyles.defaultRegularHeadline(),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class LikeSubtitle extends _Subtitle {
  const LikeSubtitle({Key? key})
      : super(
          key: key,
          icon: const AppIcon(AppIcons.like),
          text: 'Что Вам нравится?',
        );
}

class DislikeSubtitle extends _Subtitle {
  const DislikeSubtitle({Key? key})
      : super(
          key: key,
          icon: const AppIcon(AppIcons.dislike),
          text: 'А что не нравится?',
        );
}
