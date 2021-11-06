import 'package:biblosphere/src/app/book_card.dart';
import 'package:biblosphere/src/domain/entities/book.dart';
import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:biblosphere/src/app/manual_recommendation_page/manual_recommendation_cubit.dart';
import 'package:biblosphere/src/ui_kit/buttons.dart';
import 'package:biblosphere/src/ui_kit/loading_indicator.dart';
import 'package:biblosphere/src/ui_kit/styles.dart';
import 'package:biblosphere/src/ui_kit/app_bars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManualRecommendationPage extends BlocProvider<ManualRecommendationCubit> {
  ManualRecommendationPage({Key? key, required Iterable<Book> books})
      : super(
          key: key,
          create: (context) => ManualRecommendationCubit(books, context.read()),
          child: const ManualRecommendationWidget(),
        );
}

class ManualRecommendationWidget extends StatelessWidget {
  const ManualRecommendationWidget({Key? key}) : super(key: key);

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
          SliverToBoxAdapter(child: buildSubtitle()),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          _buildSliverBookList(),
        ],
      ),
    );
  }

  Widget _buildSliverBookList() {
    return BlocBuilder<ManualRecommendationCubit, ManualRecommendationState>(
      builder: (context, state) {
        if (state is LoadedState) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return BookCard(book: state.books.elementAt(index));
              },
              childCount: state.books.length,
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
        style: UIStyles.defaultRegularHeadline(),
      ),
    );
  }

  Widget _buildError(AppError error) {
    return Column(
      children: [
        Text('$error'),
        Builder(
          builder: (context) => UIButton(
            onTap: context.read<ManualRecommendationCubit>().onReload,
            child: const Text('Обновить'),
          ),
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return const Center(child: UILoadingIndicator(size: 22));
  }
}
