import 'package:biblosphere/src/app/search_dialog/search_cubit.dart';
import 'package:biblosphere/src/domain/entities/book.dart';
import 'package:biblosphere/src/domain/entities/error.dart';
import 'package:biblosphere/src/ui_kit/buttons.dart';
import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:biblosphere/src/ui_kit/loading_indicator.dart';
import 'package:biblosphere/src/ui_kit/shadows.dart';
import 'package:biblosphere/src/ui_kit/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchDialog extends BlocProvider<SearchCubit> {
  SearchDialog({Key? key})
      : super(
          key: key,
          create: (context) => SearchCubit(context.read()),
          child: const _SearchDialogWidget(),
        );
}

class _SearchDialogWidget extends StatelessWidget {
  const _SearchDialogWidget({Key? key}) : super(key: key);

  static const _searchFieldBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: UIColors.transparent),
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
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('Ручной ввод',
                          style: UIStyles.defaultRegularHeadline()),
                    ),
                    const UICloseButton(),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16)
                    .copyWith(bottom: 50),
                decoration: BoxDecoration(
                  color: UIColors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: UIShadows.lightTitle,
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
                          style: UIStyles.defaultRegularComment(
                            color: UIColors.black,
                          ),
                          onChanged:
                              context.read<SearchCubit>().onSearchChanged,
                          onEditingComplete: context
                              .read<SearchCubit>()
                              .onSearchChangingCompleted,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                              left: 16,
                              top: 21,
                              bottom: 21,
                            ),
                            hintText: 'Добавить еще...',
                            hintStyle: UIStyles.defaultRegularComment(
                              color: UIColors.textDeactive,
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
                        ...state.book.map((e) => _buildBookButton(e)),
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

  Widget _buildDivider() {
    return const Divider(indent: 16, height: 1);
  }

  Widget _buildLoadingIndicator() {
    return Container(
      height: 64,
      width: 64,
      alignment: Alignment.center,
      child: const UILoadingIndicator(size: 26),
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
                  bottom: BorderSide(color: UIColors.greyMiddle, width: 1),
                ),
              )
            : null,
        child: child,
      ),
    );
  }

  Widget _buildBookButton(Book book) {
    return Builder(
      builder: (context) => _buildRowButton(
        withDivider: true,
        onTap: () {
          Navigator.of(context).pop(book);
        },
        child: Text(
          '${book.title}, ${book.author}',
          style: UIStyles.defaultRegularComment(
            color: UIColors.textActive,
          ),
        ),
      ),
    );
  }

  Widget _buildMoreButton() {
    return Builder(
      builder: (context) => _buildRowButton(
        withDivider: false,
        onTap: context.read<SearchCubit>().onLoadUpBooks,
        child: Text(
          'Еще...',
          style: UIStyles.defaultRegularComment(color: UIColors.textDeactive),
        ),
      ),
    );
  }
}
