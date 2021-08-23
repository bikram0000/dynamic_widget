import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../dynamic_widget.dart';
import 'dynamic_widget_json_exportor.dart';

class DynamicWidgetParser extends WidgetParser {
  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as DynamicWidgetJsonExportor;
    return <String, dynamic>{
      "type": widgetName,
      "child": realWidget.child == null
          ? null
          : DynamicWidgetBuilder.export(realWidget.child, buildContext),
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    var appBarWidget = DynamicWidgetJsonExportor(
      child: map.containsKey("child")
          ? DynamicWidgetBuilder.buildFromMap(
              map["child"], buildContext, listener)
          : null,
    );

    return appBarWidget;
  }

  @override
  String get widgetName => "DynamicWidgetJsonExportor";

  @override
  Type get widgetType => DynamicWidgetJsonExportor;
}
