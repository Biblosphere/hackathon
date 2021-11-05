import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:biblosphere/src/ui_kit/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  const AddButton({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        onPressed: onTap,
        child: Text(
          '+ Добавить еще',
          textAlign: TextAlign.start,
          style: AppStyles.defaultRegularComment(color: AppColors.textDeactive),
        ),
      ),
    );
  }
}
