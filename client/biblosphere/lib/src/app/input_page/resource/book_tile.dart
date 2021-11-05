import 'package:biblosphere/src/domain/entities/book_essential.dart';
import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:biblosphere/src/ui_kit/icons.dart';
import 'package:biblosphere/src/ui_kit/styles.dart';
import 'package:flutter/material.dart';

enum BookTileActionType { like, dislike }

class BookTile extends StatelessWidget {
  const BookTile({
    Key? key,
    required this.actionType,
    required this.book,
    required this.onActionTap,
    required this.onRemoveTap,
  }) : super(key: key);

  final BookTileActionType actionType;
  final BookEssential book;
  final VoidCallback onActionTap;
  final VoidCallback onRemoveTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.greyMiddle)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '${book.title}, ${book.author}',
              maxLines: 1,
              softWrap: false,
              style:
                  AppStyles.defaultRegularComment(color: AppColors.textActive),
            ),
          ),
          PopupMenuButton(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: AppColors.white,
            //iconSize: 16,
            icon: const AppIcon(AppIcons.menu),
            itemBuilder: (context) => [
              PopupMenuItem(
                height: 24,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                onTap: onActionTap,
                child: Row(
                  children: [
                    if (actionType == BookTileActionType.like) ...[
                      const AppIcon(
                        AppIcons.heartLike,
                        color: AppColors.accent1,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Нравится',
                        style: AppStyles.defaultRegularComment(
                          color: AppColors.greyHard,
                        ),
                      ),
                    ],
                    if (actionType == BookTileActionType.dislike) ...[
                      const AppIcon(
                        AppIcons.heartDislike,
                        color: AppColors.accent1,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Не нравится',
                        style: AppStyles.defaultRegularComment(
                          color: AppColors.greyHard,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              PopupMenuItem(
                enabled: false,
                height: 1,
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 20,
                ),
                child: Container(
                  height: 1,
                  decoration: BoxDecoration(
                    color: AppColors.line,
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
              PopupMenuItem(
                height: 24,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                onTap: onRemoveTap,
                child: Row(
                  children: [
                    const AppIcon(
                      AppIcons.trash,
                      color: AppColors.accent1,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Удалить',
                      style: AppStyles.defaultRegularComment(
                        color: AppColors.greyHard,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
