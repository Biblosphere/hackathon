import 'package:biblosphere/src/app/search_dialog/search_cubit.dart';
import 'package:biblosphere/src/domain/entities/book_essential.dart';
import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:biblosphere/src/ui_kit/buttons.dart';
import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:biblosphere/src/ui_kit/icons.dart';
import 'package:biblosphere/src/ui_kit/loading.dart';
import 'package:biblosphere/src/ui_kit/shadows.dart';
import 'package:biblosphere/src/ui_kit/styles.dart';
import 'package:biblosphere/src/ui_kit/topbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SearchDialogType { like, dislike }

class SearchDialog extends StatelessWidget {
  const SearchDialog({Key? key, required this.type}) : super(key: key);

  final SearchDialogType type;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(bookEssentialRepo: context.read()),
      child: _SearchDialogWidget(type: type),
    );
  }
}

class _SearchDialogWidget extends StatelessWidget {
  const _SearchDialogWidget({Key? key, required this.type}) : super(key: key);

  final SearchDialogType type;

  static const _searchFieldBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: AppColors.transparent),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            AppSliverTopBar(onTap: Navigator.of(context).pop),
            SliverToBoxAdapter(child: _buildTitle()),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16)
                    .copyWith(bottom: 50),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: AppShadows.lightTitle,
                ),
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (_, state) => Column(
                    children: [
                      SizedBox(
                        height: 64,
                        child: TextField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.search,
                          textCapitalization: TextCapitalization.sentences,
                          style: AppStyles.defaultRegularComment(
                            color: AppColors.black,
                          ),
                          onChanged:
                              context.read<SearchCubit>().onSearchChanged,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                              left: 16,
                              top: 21,
                              bottom: 21,
                            ),
                            hintText: 'Добавить еще...',
                            hintStyle: AppStyles.defaultRegularComment(
                              color: AppColors.textDeactive,
                            ),
                            border: _searchFieldBorder,
                            enabledBorder: _searchFieldBorder,
                            errorBorder: _searchFieldBorder,
                            focusedBorder: _searchFieldBorder,
                            disabledBorder: _searchFieldBorder,
                            focusedErrorBorder: _searchFieldBorder,
                          ),
                        ),
                      ),
                      if (state is LoadingState) ...[
                        _buildDivider(),
                        _buildLoadingIndicator(),
                      ],
                      if (state is LoadedState) ...[
                        _buildDivider(),
                        ...state.bookEssentials.map((e) => _buildBookButton(e)),
                        if (state.loading) _buildLoadingIndicator(),
                        if (!state.loading && !state.finish) _buildMoreButton(),
                      ],
                      if (state is ErrorState) ...[
                        _buildDivider(),
                        _buildError(state.error),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    late final AppIcons icon;
    switch (type) {
      case SearchDialogType.like:
        icon = AppIcons.like;
        break;
      case SearchDialogType.dislike:
        icon = AppIcons.dislike;
        break;
    }
    late final String title;
    switch (type) {
      case SearchDialogType.like:
        title = 'Что Вам нравится?';
        break;
      case SearchDialogType.dislike:
        title = 'А что не нравится?';
        break;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          AppIcon(icon),
          const SizedBox(width: 16),
          Expanded(
            child: Text(title, style: AppStyles.defaultRegularHeadline()),
          ),
          const AppCloseButton(),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(indent: 16, height: 1);
  }

  Widget _buildLoadingIndicator() {
    return Container(
      height: 64,
      width: 64,
      alignment: Alignment.center,
      child: const AppLoading(size: 26),
    );
  }

  Widget _buildError(AppError error) {
    return Container(
      height: 64,
      width: 64,
      alignment: Alignment.center,
      child: const Text('Ошибка'),
    );
  }

  Widget _buildRowButton({
    required VoidCallback onTap,
    required Widget child,
    required bool withDivider,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 16),
        padding: const EdgeInsets.fromLTRB(0, 23, 12, 19),
        alignment: Alignment.centerLeft,
        decoration: withDivider
            ? const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.greyMiddle, width: 1),
                ),
              )
            : null,
        child: child,
      ),
    );
  }

  Widget _buildBookButton(BookEssential bookEssential) {
    return Builder(
      builder: (context) => _buildRowButton(
        withDivider: true,
        onTap: () {
          Navigator.of(context).pop(bookEssential);
        },
        child: Text(
          '${bookEssential.title}, ${bookEssential.author}',
          style: AppStyles.defaultRegularComment(
            color: AppColors.textActive,
          ),
        ),
      ),
    );
  }

  Widget _buildMoreButton() {
    return Builder(
      builder: (context) => _buildRowButton(
        withDivider: false,
        onTap: context.read<SearchCubit>().onMoreButtonTap,
        child: Text(
          'Еще...',
          style: AppStyles.defaultRegularComment(color: AppColors.textDeactive),
        ),
      ),
    );
  }
}
