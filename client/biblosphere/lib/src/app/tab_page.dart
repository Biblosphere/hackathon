import 'package:biblosphere/src/app/cold_start_tab/cold_start_tab.dart';
import 'package:biblosphere/src/app/id_search_tab/id_search_tab.dart';
import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:biblosphere/src/ui_kit/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TabPage extends StatelessWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Column(
              children: [
                _buildTabBar(),
                _buildTabPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    final titles = ['Ввести  ID', 'Холодный старт'];
    Widget buildTab(String text) {
      return Tab(
        child: Text(
          text,
          style: UIStyles.defaultRegularHeadline(
            color: UIColors.accent1,
          ),
        ),
      );
    }

    return TabBar(
      indicatorColor: UIColors.accent1,
      tabs: titles.map((e) => buildTab(e)).toList(),
    );
  }

  Widget _buildTabPage() {
    return Expanded(
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        children: [IdSearchTab(), ColdStartTab()],
      ),
    );
  }
}
