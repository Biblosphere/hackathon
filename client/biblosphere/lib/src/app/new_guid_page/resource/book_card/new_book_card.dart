import 'package:biblosphere/src/domain/entities/new_book.dart';
import 'package:biblosphere/src/ui_kit/buttons.dart';
import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:biblosphere/src/ui_kit/icons.dart';
import 'package:biblosphere/src/ui_kit/shadows.dart';
import 'package:biblosphere/src/ui_kit/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewBookCard extends StatelessWidget {
  const NewBookCard({Key? key, required this.newBook}) : super(key: key);

  final NewBook newBook;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: AppShadows.lightTitle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBookImage(),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newBook.title,
                      style: AppStyles.defaultRegularHeadline(
                        color: AppColors.textActive,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Автор: ${newBook.author}',
                      style: AppStyles.defaultRegularComment(
                        color: AppColors.line,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          AppButton(
            onTap: () {},
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppIcon(AppIcons.geo, color: AppColors.white),
                const SizedBox(width: 20),
                Text(
                  'Забронировать',
                  style: AppStyles.defaultRegularHeadline(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookImage() {
    return Builder(
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final width = screenWidth * 0.31734;
        final height = width * 1.34453782;
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: AppColors.book,
            boxShadow: AppShadows.lightTitle,
            borderRadius: BorderRadius.circular(7),
          ),
        );
      },
    );
  }
}
