import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';

import '../../dynamic_widget.dart';

class TextFieldWidgetParser implements WidgetParser {
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    String? textAlignString = map['textAlign'];
    return TextField(
      textAlign: parseTextAlign(textAlignString),
      style: map.containsKey('style') ? parseTextStyle(map['style']) : null,
      decoration: parseInputDecoration(map['decoration']),
    );
  }

  @override
  String get widgetName => "TextField";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as TextField;
    return <String, dynamic>{
      "type": "TextField",
      "textAlign": realWidget.textAlign != null
          ? exportTextAlign(realWidget.textAlign)
          : "start",
      "style": exportTextStyle(realWidget.style),
      "decoration": exportInputDecoration(realWidget.decoration),
    };
  }

  @override
  Type get widgetType => TextField;

  @override
  bool matchWidgetForExport(Widget? widget) => widget is TextField;
}
