import 'package:biblosphere/src/domain/entities/book.dart';
import 'package:biblosphere/src/app/guid/resource/book_card/book_details_popup.dart';
import 'package:biblosphere/src/ui_kit/buttons.dart';
import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:biblosphere/src/ui_kit/icons.dart';
import 'package:biblosphere/src/ui_kit/loading.dart';
import 'package:biblosphere/src/ui_kit/shadows.dart';
import 'package:biblosphere/src/ui_kit/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard({Key? key, required this.book}) : super(key: key);

  final Book book;

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
                      book.title,
                      style: AppStyles.defaultRegularHeadline(
                        color: AppColors.textActive,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Автор: ${book.author}',
                      style: AppStyles.defaultRegularComment(
                        color: AppColors.line,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Описание:',
                      style: AppStyles.defaultRegularBody(
                        color: AppColors.greyHeavy,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book.description,
                      maxLines: 2,
                      style: AppStyles.defaultRegularComment(
                        color: AppColors.greyHard,
                      ),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => showCupertinoModalPopup(
                        context: context,
                        builder: (_) => BookDetailsPopup(book: book),
                      ),
                      child: Container(
                        height: 22,
                        color: AppColors.transparent,
                        child: Text(
                          'Подробнее',
                          style: AppStyles.defaultRegularComment(
                            color: AppColors.accent1,
                          ),
                        ),
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
        const placeholder = SizedBox();
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: AppColors.book,
            boxShadow: AppShadows.lightTitle,
            borderRadius: BorderRadius.circular(7),
          ),
          child: (book.imageUrl == null)
              ? placeholder
              : ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: CachedNetworkImage(
                    imageUrl: book.imageUrl!,
                    progressIndicatorBuilder: (_, __, progress) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          placeholder,
                          AppLoading(
                            progress: progress.progress,
                            size: 17,
                            width: 2,
                          ),
                        ],
                      );
                    },
                    //placeholder: (_, __) => placeholder,
                    errorWidget: (_, __, ___) => placeholder,
                    height: height,
                    width: width,
                    fit: BoxFit.cover,
                  ),
                ),
        );
      },
    );
  }
}
