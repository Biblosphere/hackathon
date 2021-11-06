import 'package:biblosphere/src/domain/entities/book.dart';
import 'package:biblosphere/src/ui_kit/buttons.dart';
import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:biblosphere/src/ui_kit/icons.dart';
import 'package:biblosphere/src/ui_kit/loading_indicator.dart';
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
        color: UIColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: UIShadows.lightTitle,
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
              _buildBookImage(book.imageUrl),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: UIStyles.defaultRegularHeadline(
                        color: UIColors.textActive,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Автор: ${book.author}',
                      style: UIStyles.defaultRegularComment(
                        color: UIColors.line,
                      ),
                    ),
                    if (book.description != null) ...[
                      const SizedBox(height: 20),
                      Text(
                        'Описание:',
                        style: UIStyles.defaultRegularBody(
                          color: UIColors.greyHeavy,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        book.description!,
                        maxLines: 2,
                        style: UIStyles.defaultRegularComment(
                          color: UIColors.greyHard,
                        ),
                      ),
                    ],
                    if (book.description != null) ...[
                      const SizedBox(height: 4),
                      Builder(
                        builder: (context) => GestureDetector(
                          onTap: () => showCupertinoModalPopup(
                            context: context,
                            builder: (_) => _buildDescriptionPopup(
                              book.description!,
                            ),
                          ),
                          child: Container(
                            height: 22,
                            color: UIColors.transparent,
                            child: Text(
                              'Подробнее',
                              style: UIStyles.defaultRegularComment(
                                color: UIColors.accent1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          UIButton(
            onTap: () {},
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const UIIcon(UIIcons.geo, color: UIColors.white),
                const SizedBox(width: 20),
                Text(
                  'Забронировать',
                  style: UIStyles.defaultRegularHeadline(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookImage(String? imageUrl) {
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
            color: UIColors.book,
            boxShadow: UIShadows.lightTitle,
            borderRadius: BorderRadius.circular(7),
          ),
          child: (imageUrl == null)
              ? placeholder
              : ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    progressIndicatorBuilder: (_, __, progress) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          placeholder,
                          UILoadingIndicator(
                            progress: progress.progress,
                            size: 17,
                            width: 2,
                          ),
                        ],
                      );
                    },
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

  Widget _buildDescriptionPopup(String description) {
    return Material(
      color: UIColors.white,
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
                  style: UIStyles.defaultRegularHeadline(),
                ),
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: Navigator.of(context).pop,
                    child: const UIIcon(UIIcons.close),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              description,
              style: UIStyles.defaultRegularBody(color: UIColors.greyHard),
            ),
          ],
        ),
      ),
    );
  }
}
