import 'package:biblosphere/src/domain/entities/book_essential.dart';
import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:biblosphere/src/app/guid/guid_cubit.dart';
import 'package:biblosphere/src/app/guid/resource/book_card/book_card.dart';
import 'package:biblosphere/src/ui_kit/buttons.dart';
import 'package:biblosphere/src/ui_kit/loading.dart';
import 'package:biblosphere/src/ui_kit/styles.dart';
import 'package:biblosphere/src/ui_kit/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuidPage extends StatelessWidget {
  const GuidPage({
    Key? key,
    required this.likeBooks,
    required this.dislikeBooks,
  }) : super(key: key);

  final Iterable<BookEssential> likeBooks;
  final Iterable<BookEssential> dislikeBooks;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GuidCubit(likeBooks, dislikeBooks, context.read()),
      child: const _GuidPageWidget(),
    );
  }
}

class _GuidPageWidget extends StatelessWidget {
  const _GuidPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GuidCubit>();
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          AppSliverTopBar(onTap: Navigator.of(context).pop),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
          BlocBuilder<GuidCubit, GuidState>(
            builder: (context, state) {
              if (state is LoadedState) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == 0) return buildSubtitle();
                      if (index == 1) return const SizedBox(height: 20);
                      index -= 2;
                      return BookCard(book: state.books.elementAt(index));
                    },
                    childCount: state.books.length + 2,
                  ),
                );
              }
              if (state is ErrorState) {
                return SliverToBoxAdapter(
                  child: buildError(state.error, cubit.handleReloadTap),
                );
              }
              return SliverToBoxAdapter(child: buildLoading());
            },
          ),
        ],
      ),
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

  Widget buildLoading() {
    return const Center(child: AppLoading(size: 22));
  }

  Widget buildError(AppError error, VoidCallback onReloadTap) {
    return Column(
      children: [
        Text('$error'),
        AppButton(
          onTap: onReloadTap,
          child: const Text('Обновить'),
        ),
      ],
    );
  }
}
