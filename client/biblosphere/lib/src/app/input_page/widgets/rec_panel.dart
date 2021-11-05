import 'package:biblosphere/src/domain/entities/book_essential.dart';
import 'package:biblosphere/src/resource/resource.dart';
import 'package:biblosphere/src/ui_kit/colors.dart';
import 'package:biblosphere/src/ui_kit/styles.dart';
import 'package:flutter/material.dart';

class BookRecPanel extends StatefulWidget {
  const BookRecPanel({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BookRecPanelState();
}

class _BookRecPanelState extends State<BookRecPanel> {
  var _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      elevation: 0,
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (_, __) => setState(
        () => _isExpanded = !_isExpanded,
      ),
      children: [
        ExpansionPanel(
          isExpanded: _isExpanded,
          headerBuilder: (_, opened) => SizedBox(
            height: 24,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              title: Text(
                'Рекомендации',
                maxLines: 1,
                style: AppStyles.defaultRegularHeadline(),
              ),
            ),
          ),
          body: Column(
            children:
                Resource.instance.recBooks.map(_buildBookEssential).toList(),
          ),
        )
      ],
    );
  }

  Widget _buildBookEssential(BookEssential bookEssential) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.greyMiddle),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(width: double.infinity),
                Text(
                  bookEssential.title,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.defaultRegularComment(
                      color: AppColors.textActive),
                ),
                Text(
                  bookEssential.author,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.defaultRegularComment(
                      color: AppColors.textActive),
                ),
              ],
            ),
          ),
          // Checkbox(
          //   value: value,
          //   onChanged: onChanged,
          // ),
        ],
      ),
    );
  }
}
