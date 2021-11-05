import 'package:biblosphere/src/app/new_guid_page/new_guid_cubit.dart';
import 'package:biblosphere/src/app/new_guid_page/resource/book_card/new_book_card.dart';
import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:biblosphere/src/ui_kit/buttons.dart';
import 'package:biblosphere/src/ui_kit/loading.dart';
import 'package:biblosphere/src/ui_kit/styles.dart';
import 'package:biblosphere/src/ui_kit/topbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewGuidPage extends StatelessWidget {
  const NewGuidPage({Key? key, required this.userId}) : super(key: key);

  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewGuidCubit(userId, context.read()),
      child: const _NewGuidPageWidget(),
    );
  }
}

class _NewGuidPageWidget extends StatelessWidget {
  const _NewGuidPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NewGuidCubit>();
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          AppSliverTopBar(onTap: Navigator.of(context).pop),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
          BlocBuilder<NewGuidCubit, NewGuidState>(
            builder: (context, state) {
              if (state is LoadedState) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == 0) return buildSubtitle();
                      if (index == 1) return const SizedBox(height: 20);
                      index -= 2;
                      return NewBookCard(
                        newBook: state.newBooks.elementAt(index),
                      );
                    },
                    childCount: state.newBooks.length + 2,
                  ),
                );
              }
              if (state is ErrorState) {
                return SliverToBoxAdapter(
                  child: buildError(state.error, cubit.handleReloadButtonTap),
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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text('$error'),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppButton(
            onTap: onReloadTap,
            child: const Text('Обновить'),
          ),
        ),
      ],
    );
  }
}
