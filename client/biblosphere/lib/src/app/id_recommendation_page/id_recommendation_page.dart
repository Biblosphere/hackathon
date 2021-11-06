import 'package:biblosphere/src/app/id_recommendation_page/id_recommendation_cubit.dart';
import 'package:biblosphere/src/domain/entities/book.dart';
import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:biblosphere/src/ui_kit/buttons.dart';
import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:biblosphere/src/ui_kit/icons.dart';
import 'package:biblosphere/src/ui_kit/loading.dart';
import 'package:biblosphere/src/ui_kit/shadows.dart';
import 'package:biblosphere/src/ui_kit/styles.dart';
import 'package:biblosphere/src/ui_kit/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdRecommendationPage extends BlocProvider<IdRecommendationCubit> {
  IdRecommendationPage({Key? key, required String id})
      : super(
          key: key,
          create: (context) => IdRecommendationCubit(id, context.read()),
          child: const _IdRecommendationPageWidget(),
        );
}

class _IdRecommendationPageWidget extends StatelessWidget {
  const _IdRecommendationPageWidget({Key? key}) : super(key: key);

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
          SliverToBoxAdapter(child: _buildSubtitle()),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          _buildSliverBookList(),
        ],
      ),
    );
  }

  Widget _buildSubtitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Text(
        'Вам может понравиться:',
        style: AppStyles.defaultRegularHeadline(),
      ),
    );
  }

  Widget _buildSliverBookList() {
    return BlocBuilder<IdRecommendationCubit, IdRecommendationState>(
      builder: (context, state) {
        if (state is LoadedState) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildBookCard(
                state.books.elementAt(index),
              ),
              childCount: state.books.length,
            ),
          );
        }
        if (state is ErrorState) {
          return SliverToBoxAdapter(
            child: _buildLoadingBooksError(state.error),
          );
        }
        return SliverToBoxAdapter(child: _buildLoading());
      },
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
              Builder(
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
              ),
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

  Widget _buildLoadingBooksError(AppError error) {
    return Builder(
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Ошибка'),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppButton(
              onTap: context.read<IdRecommendationCubit>().onReload,
              child: const Text('Обновить'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: AppLoading(size: 22));
  }
}
