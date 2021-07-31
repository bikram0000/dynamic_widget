import 'dart:ui';

import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class BackdropFilterWidgetParser extends WidgetParser {
  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    BackdropFilter backdropFilter = widget as BackdropFilter;
    String imageFilter = backdropFilter.filter.toString();
    return <String, dynamic>{
      "type": widgetName,
      "filter": imageFilter,
      "child": DynamicWidgetBuilder.export(backdropFilter.child, buildContext)
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    String imageFilter1 = map['filter']
        .toString()
        .replaceAll('ImageFilter.blur(', '')
        .replaceAll(')', '');
    var split = imageFilter1.split(',');
    double sigmaX = double.parse(split[0]);
    double sigmaY = double.parse(split[1]);
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: sigmaX,
        sigmaY: sigmaY,
      ),
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }

  @override
  // TODO: implement widgetName
  String get widgetName => "BackdropFilter";

  @override
  // TODO: implement widgetType
  Type get widgetType => BackdropFilter;
}
