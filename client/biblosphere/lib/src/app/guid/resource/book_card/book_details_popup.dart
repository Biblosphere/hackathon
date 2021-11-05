import 'package:biblosphere/src/domain/entities/book.dart';
import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:biblosphere/src/ui_kit/icons.dart';
import 'package:biblosphere/src/ui_kit/styles.dart';
import 'package:flutter/material.dart';

class BookDetailsPopup extends StatelessWidget {
  const BookDetailsPopup({Key? key, required this.book}) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Подробнее',
                  style: AppStyles.defaultRegularHeadline(),
                ),
                GestureDetector(
                  onTap: Navigator.of(context).pop,
                  child: const AppIcon(AppIcons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              book.description,
              style: AppStyles.defaultRegularBody(color: AppColors.greyHard),
            ),
          ],
        ),
      ),
    );
  }
}
