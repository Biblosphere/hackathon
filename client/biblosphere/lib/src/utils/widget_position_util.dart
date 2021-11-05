import 'package:flutter/material.dart';

Offset getWidgetPosition(GlobalKey key) {
  final widget = key.currentContext!.findRenderObject() as RenderBox;
  return widget.localToGlobal(Offset.zero);
}
