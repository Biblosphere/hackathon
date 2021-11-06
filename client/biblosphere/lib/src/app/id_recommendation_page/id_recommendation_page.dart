import 'package:biblosphere/src/app/book_card.dart';
import 'package:biblosphere/src/app/id_recommendation_page/id_recommendation_cubit.dart';
import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:biblosphere/src/ui_kit/buttons.dart';
import 'package:biblosphere/src/ui_kit/loading_indicator.dart';
import 'package:biblosphere/src/ui_kit/styles.dart';
import 'package:biblosphere/src/ui_kit/app_bars.dart';
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
          UISliverBackButtonAppBar(),
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
        style: UIStyles.defaultRegularHeadline(),
      ),
    );
  }

  Widget _buildSliverBookList() {
    return BlocBuilder<IdRecommendationCubit, IdRecommendationState>(
      builder: (context, state) {
        if (state is LoadedState) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => BookCard(book: state.books.elementAt(index)),
              childCount: state.books.length,
            ),
          );
        }
        if (state is ErrorState) {
          return SliverToBoxAdapter(
            child: _buildLoadingBooksError(state.error),
          );
        }
        return SliverToBoxAdapter(child: _buildLoadingIndicator());
      },
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
            child: UIButton(
              onTap: context.read<IdRecommendationCubit>().onReload,
              child: const Text('Обновить'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(child: UILoadingIndicator(size: 22));
  }
}
