import 'package:biblosphere/src/app/cold_start_tab/cold_start_cubit.dart';
import 'package:biblosphere/src/app/manual_recommendation_page/manual_recommendation_page.dart';
import 'package:biblosphere/src/app/search_dialog/search_dialog.dart';
import 'package:biblosphere/src/core/selectable_value.dart';
import 'package:biblosphere/src/domain/entities/book.dart';
import 'package:biblosphere/src/ui_kit/buttons.dart';
import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:biblosphere/src/ui_kit/icons.dart';
import 'package:biblosphere/src/ui_kit/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColdStartTab extends BlocProvider<ColdStartCubit> {
  ColdStartTab({Key? key})
      : super(
          key: key,
          create: (_) => ColdStartCubit(),
          child: const _ColdStartTabWidget(),
        );
}

class _ColdStartTabWidget extends StatelessWidget {
  const _ColdStartTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          _buildRecommendationPanel(),
          const SizedBox(height: 16),
          _buildManualTitle(),
          const SizedBox(height: 16),
          _buildManualBookList(),
          _buildAddBookButton(),
          const Divider(indent: 16, endIndent: 16, height: 1),
          const SizedBox(height: 40),
          _buildRecommendationButton(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildRecommendationPanel() {
    return BlocBuilder<ColdStartCubit, ColdStartState>(
      buildWhen: (prev, cur) => prev.recommendedBooks != cur.recommendedBooks,
      builder: (context, state) => _RecommendationPanel(
        recommendedBooks: state.recommendedBooks.toList()
          ..sort((a, b) => a.value.title.compareTo(b.value.title)),
        onChanged: (book, isSelected) => context
            .read<ColdStartCubit>()
            .onRecommendedBookChanged(book, isSelected),
      ),
    );
  }

  Widget _buildManualTitle() {
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        'Ручной ввод',
        maxLines: 1,
        style: UIStyles.defaultRegularHeadline(),
      ),
    );
  }

  Widget _buildManualBookList() {
    return BlocBuilder<ColdStartCubit, ColdStartState>(
      buildWhen: (prev, cur) {
        if (prev.manualBooks != cur.manualBooks) return true;
        return false;
      },
      builder: (context, state) {
        return Column(
          children:
              state.manualBooks.map((e) => _buildManualBookTile(e)).toList(),
        );
      },
    );
  }

  Widget _buildManualBookTile(Book book) {
    return Container(
      height: 64,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: UIColors.greyMiddle)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '${book.title}, ${book.author}',
              maxLines: 1,
              softWrap: false,
              style: UIStyles.defaultRegularComment(color: UIColors.textActive),
            ),
          ),
          PopupMenuButton(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: UIColors.white,
            icon: const UIIcon(UIIcons.menu),
            itemBuilder: (context) => [
              PopupMenuItem(
                height: 24,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                onTap: () =>
                    context.read<ColdStartCubit>().onRemoveManualBook(book),
                child: Row(
                  children: [
                    const UIIcon(
                      UIIcons.trash,
                      color: UIColors.accent1,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Удалить',
                      style: UIStyles.defaultRegularComment(
                        color: UIColors.greyHard,
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

  Widget _buildAddBookButton() {
    return Builder(
      builder: (context) => SizedBox(
        height: 60,
        width: double.infinity,
        child: CupertinoButton(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          onPressed: () async {
            final book = await showDialog<Book>(
              context: context,
              barrierColor: UIColors.transparent,
              builder: (_) => SearchDialog(),
            );
            if (book != null) {
              context.read<ColdStartCubit>().onAddManualBook(book);
            }
          },
          child: Text(
            '+ Добавить еще',
            textAlign: TextAlign.start,
            style: UIStyles.defaultRegularComment(color: UIColors.textDeactive),
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<ColdStartCubit, ColdStartState>(
        buildWhen: (prev, cur) {
          final prevBooks = [
            ...prev.recommendedBooks
                .where((e) => e.isSelected)
                .map((e) => e.value),
            ...prev.manualBooks,
          ];

          final curBooks = [
            ...cur.recommendedBooks
                .where((e) => e.isSelected)
                .map((e) => e.value),
            ...cur.manualBooks,
          ];

          return prevBooks.isNotEmpty != curBooks.isNotEmpty;
        },
        builder: (context, state) {
          final books = [
            ...state.recommendedBooks
                .where((e) => e.isSelected)
                .map((e) => e.value),
            ...state.manualBooks,
          ];
          return UIButton(
            active: books.isNotEmpty,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ManualRecommendationPage(books: books),
                ),
              );
            },
            child: Text(
              'Подобрать рекомендации',
              style: UIStyles.defaultRegularHeadline(color: UIColors.white),
            ),
          );
        },
      ),
    );
  }
}

class _RecommendationPanel extends StatefulWidget {
  const _RecommendationPanel({
    Key? key,
    required this.recommendedBooks,
    required this.onChanged,
  }) : super(key: key);

  final Iterable<SelectableValue<Book>> recommendedBooks;
  final Function(Book book, bool selected) onChanged;

  @override
  State<StatefulWidget> createState() => _RecommendationPanelState();
}

class _RecommendationPanelState extends State<_RecommendationPanel> {
  var _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      elevation: 0,
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (_, __) => setState(() => _isExpanded = !_isExpanded),
      children: [
        ExpansionPanel(
          isExpanded: _isExpanded,
          headerBuilder: (_, __) => SizedBox(
            height: 24,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              title: Text(
                'Рекомендации',
                maxLines: 1,
                style: UIStyles.defaultRegularHeadline(),
              ),
            ),
          ),
          body: Column(
            children: widget.recommendedBooks.map(_buildTile).toList(),
          ),
        )
      ],
    );
  }

  Widget _buildTile(SelectableValue<Book> selectableBook) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: UIColors.greyMiddle),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${selectableBook.value.title}, ${selectableBook.value.author}',
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: UIStyles.defaultRegularComment(color: UIColors.textActive),
            ),
          ),
          Checkbox(
            activeColor: UIColors.accent1,
            value: selectableBook.isSelected,
            onChanged: (isSelected) => widget.onChanged(
              selectableBook.value,
              isSelected!,
            ),
          ),
        ],
      ),
    );
  }
}
