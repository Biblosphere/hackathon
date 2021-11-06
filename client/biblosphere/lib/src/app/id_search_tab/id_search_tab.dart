import 'package:biblosphere/src/app/id_search_tab/id_serach_cubit.dart';
import 'package:biblosphere/src/app/id_recommendation_page/id_recommendation_page.dart';
import 'package:biblosphere/src/ui_kit/buttons.dart';
import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:biblosphere/src/ui_kit/shadows.dart';
import 'package:biblosphere/src/ui_kit/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdSearchTab extends BlocProvider<IdSearchCubit> {
  IdSearchTab({Key? key})
      : super(
          key: key,
          create: (_) => IdSearchCubit(),
          child: const _IdSearchTabWidget(),
        );
}

class _IdSearchTabWidget extends StatelessWidget {
  const _IdSearchTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildIdField(),
          _buildRecommendationButton(),
        ],
      ),
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
      child: Builder(
        builder: (context) => TextField(
          onChanged: context.read<IdSearchCubit>().onIdChanged,
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
      ),
    );
  }

  Widget _buildRecommendationButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocBuilder<IdSearchCubit, IdSearchState>(
        buildWhen: (prev, cur) => prev.id != cur.id,
        builder: (context, state) => AppButton(
          active: state.id.isNotEmpty,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => IdRecommendationPage(id: state.id),
              ),
            );
          },
          child: Text(
            'Подобрать рекомендации',
            style: AppStyles.defaultRegularHeadline(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
