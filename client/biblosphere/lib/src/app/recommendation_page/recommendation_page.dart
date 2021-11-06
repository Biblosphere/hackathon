import 'package:biblosphere/src/domain/entities/book.dart';
import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:biblosphere/src/app/recommendation_page/recommendation_cubit.dart';
import 'package:biblosphere/src/ui_kit/buttons.dart';
import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:biblosphere/src/ui_kit/icons.dart';
import 'package:biblosphere/src/ui_kit/loading.dart';
import 'package:biblosphere/src/ui_kit/shadows.dart';
import 'package:biblosphere/src/ui_kit/styles.dart';
import 'package:biblosphere/src/ui_kit/topbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendationPage extends BlocProvider<RecommendationCubit> {
  RecommendationPage({Key? key, required Iterable<Book> books})
      : super(
          key: key,
          create: (context) => RecommendationCubit(books, context.read()),
          child: const _GuidPageWidget(),
        );
}

class _GuidPageWidget extends StatelessWidget {
  const _GuidPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverBackButtonAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
          _buildSliverBookList(),
        ],
      ),
    );
  }

  Widget _buildSliverBookList() {
    return BlocBuilder<RecommendationCubit, RecommendationState>(
      builder: (context, state) {
        if (state is LoadedState) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 0) return buildSubtitle();
                if (index == 1) return const SizedBox(height: 20);
                index -= 2;
                return _buildBookCard(state.books.elementAt(index));
              },
              childCount: state.books.length + 2,
            ),
          );
        }
        if (state is ErrorState) {
          return SliverToBoxAdapter(
            child: _buildError(state.error),
          );
        }
        return SliverToBoxAdapter(child: _buildLoading());
      },
    );
  }

  Widget buildSubtitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        'Вам может понравиться:',
        style: AppStyles.defaultRegularHeadline(),
      ),
    );
  }

  Widget _buildBookCard(Book book) {
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
                    if (book.description != null) ...[
                      const SizedBox(height: 20),
                      Text(
                        'Описание:',
                        style: AppStyles.defaultRegularBody(
                          color: AppColors.greyHeavy,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        book.description!,
                        maxLines: 2,
                        style: AppStyles.defaultRegularComment(
                          color: AppColors.greyHard,
                        ),
                      ),
                    ],
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
                          color: AppColors.transparent,
                          child: Text(
                            'Подробнее',
                            style: AppStyles.defaultRegularComment(
                              color: AppColors.accent1,
                            ),
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

  Widget _buildError(AppError error) {
    return Column(
      children: [
        Text('$error'),
        Builder(
          builder: (context) => AppButton(
            onTap: context.read<RecommendationCubit>().onReload,
            child: const Text('Обновить'),
          ),
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return const Center(child: AppLoading(size: 22));
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
            color: AppColors.book,
            boxShadow: AppShadows.lightTitle,
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
                          AppLoading(
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
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: Navigator.of(context).pop,
                    child: const AppIcon(AppIcons.close),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              description,
              style: AppStyles.defaultRegularBody(color: AppColors.greyHard),
            ),
          ],
        ),
      ),
    );
  }
}
