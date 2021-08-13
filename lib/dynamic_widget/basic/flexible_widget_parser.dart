import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/material.dart';

class FlexibleWidgetParser extends WidgetParser {
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    var appBarWidget = Flexible(
      child: map.containsKey("child")
          ? DynamicWidgetBuilder.buildFromMap(
                  map["child"], buildContext, listener) ??
              Container()
          : Container(),
    );

    return appBarWidget;
  }

  @override
  String get widgetName => "Flexible";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Flexible;

    return <String, dynamic>{
      "type": widgetName,
      "child": realWidget.child == null
          ? null
          : DynamicWidgetBuilder.export(realWidget.child, buildContext),
    };
  }

  @override
  Type get widgetType => Flexible;
}
