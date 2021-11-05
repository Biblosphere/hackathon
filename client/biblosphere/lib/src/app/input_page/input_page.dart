import 'package:biblosphere/src/app/input_page/widgets/rec_panel.dart';
import 'package:biblosphere/src/app/new_guid_page/new_guid_page.dart';
import 'package:biblosphere/src/app/search_dialog/search_dialog.dart';
import 'package:biblosphere/src/app/guid/guid_page.dart';
import 'package:biblosphere/src/app/input_page/input_cubit.dart';
import 'package:biblosphere/src/app/input_page/resource/book_tile.dart';
import 'package:biblosphere/src/app/input_page/resource/photo_button.dart';
import 'package:biblosphere/src/app/input_page/resource/subtitle.dart';
import 'package:biblosphere/src/app/input_page/widgets/add_button.dart';
import 'package:biblosphere/src/domain/entities/book_essential.dart';
import 'package:biblosphere/src/ui_kit/buttons.dart';
import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:biblosphere/src/ui_kit/shadows.dart';
import 'package:biblosphere/src/ui_kit/styles.dart';
import 'package:biblosphere/src/ui_kit/topbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputPage extends StatelessWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InputCubit(context.read()),
      child: _InputWidget(),
    );
  }
}

class _InputWidget extends StatelessWidget {
  _InputWidget({Key? key}) : super(key: key);
  final _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kIsWeb ? null : AppTopBar(),
      body: DefaultTabController(
        length: 2,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Column(
            children: [
              if (kIsWeb) AppTopBar(),
              TabBar(
                indicatorColor: AppColors.accent1,
                //labelPadding: const EdgeInsets.symmetric(horizontal: 68),
                //indicatorPadding: const EdgeInsets.symmetric(horizontal: 68),
                tabs: [
                  Tab(
                    child: Text(
                      'Ввести  id',
                      style: AppStyles.defaultRegularHeadline(
                        color: AppColors.accent1,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Ввести книги вручную',
                      style: AppStyles.defaultRegularHeadline(
                        color: AppColors.accent1,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildIdTabView(),
                    _buildManualTabView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIdTabView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        _buildIdField(),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _buildRecommendationNewBooksButton(),
        ),
      ],
    );
  }

  Widget _buildManualTabView() {
    return Builder(
      builder: (context) {
        final cubit = context.read<InputCubit>();
        return ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          //mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const BookRecPanel(),
            const SizedBox(height: 16),
            const LikeSubtitle(),
            const SizedBox(height: 16),
            const PhotoButton(),
            const SizedBox(height: 16),
            BlocBuilder<InputCubit, InputState>(
              buildWhen: (prev, cur) {
                if (prev.likeBooks != cur.likeBooks) return true;
                return prev != cur;
              },
              builder: (context, state) {
                return Column(
                  children: state.likeBooks
                      .map((e) => BookTile(
                            actionType: BookTileActionType.dislike,
                            book: e,
                            onActionTap: () =>
                                cubit.handleReplaceBookToDislike(e),
                            onRemoveTap: () => cubit.handleRemoveLikeBook(e),
                          ))
                      .toList(),
                );
              },
            ),
            AddButton(
              onTap: () async {
                final bookEssential = await showDialog(
                  context: context,
                  barrierColor: AppColors.transparent,
                  builder: (_) => const SearchDialog(
                    type: SearchDialogType.like,
                  ),
                );
                if (bookEssential != null) {
                  cubit.handleAddLikeBook(bookEssential);
                }
              },
            ),
            const Divider(indent: 16, endIndent: 16, height: 1),
            const SizedBox(height: 40),
            const DislikeSubtitle(),
            const SizedBox(height: 16),
            BlocBuilder<InputCubit, InputState>(
              buildWhen: (prev, cur) {
                if (prev.dislikeBooks != cur.dislikeBooks) return true;
                return prev != cur;
              },
              builder: (context, state) {
                return Column(
                  children: state.dislikeBooks
                      .map((e) => BookTile(
                            actionType: BookTileActionType.like,
                            book: e,
                            onActionTap: () => cubit.handleReplaceBookToLike(e),
                            onRemoveTap: () => cubit.handleRemoveDislikeBook(e),
                          ))
                      .toList(),
                );
              },
            ),
            AddButton(
              onTap: () async {
                final bookEssential = await showDialog<BookEssential>(
                  context: context,
                  barrierColor: AppColors.transparent,
                  builder: (_) => const SearchDialog(
                    type: SearchDialogType.dislike,
                  ),
                );
                if (bookEssential != null) {
                  cubit.handleAddDislikeBook(bookEssential);
                }
              },
            ),
            const Divider(indent: 16, endIndent: 16, height: 1),
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildRecommendationButton(),
            ),
            const SizedBox(height: 40),
          ],
        );
      },
    );
  }

  Widget _buildIdField() {
    const border = UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.transparent),
    );
    return Container(
      height: 68,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: AppShadows.lightTitle,
      ),
      child: TextField(
        controller: _idController,
        style: AppStyles.defaultRegularBody(color: AppColors.black),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 23, 4, 23),
          hintText: 'Введите Ваш id',
          hintStyle: AppStyles.defaultRegularBody(
            color: AppColors.textDeactive,
          ),
          border: border,
          errorBorder: border,
          enabledBorder: border,
          focusedBorder: border,
          disabledBorder: border,
          focusedErrorBorder: border,
        ),
      ),
    );
  }

  Widget _buildRecommendationButton() {
    return BlocBuilder<InputCubit, InputState>(
      builder: (context, state) => AppButton(
        active: !state.scanning &&
            (state.likeBooks.isNotEmpty || state.dislikeBooks.isNotEmpty),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => GuidPage(
                likeBooks: state.likeBooks,
                dislikeBooks: state.dislikeBooks,
              ),
            ),
          );
        },
        child: Text(
          state.scanning ? 'Идет обработка фото ...' : 'Подобрать рекомендации',
          style: AppStyles.defaultRegularHeadline(color: AppColors.white),
        ),
      ),
    );
  }

  Widget _buildRecommendationNewBooksButton() {
    return Builder(
      builder: (context) => AppButton(
        active: true,
        onTap: () {
          final userId = _idController.text.trim();
          if (userId.isNotEmpty) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => NewGuidPage(userId: userId),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Поле пустое. Пожалуйста, введите id.'),
              ),
            );
          }
        },
        child: Text(
          'Подобрать рекомендации',
          style: AppStyles.defaultRegularHeadline(color: AppColors.white),
        ),
      ),
    );
  }
}
