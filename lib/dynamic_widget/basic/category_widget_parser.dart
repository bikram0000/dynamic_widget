import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class CategoryWidgetParser extends WidgetParser {
  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    CategoryWidget swiperWidget = widget as CategoryWidget;
    return <String, dynamic>{
      "type": "CategoryWidget",
      "children": DynamicWidgetBuilder.exportWidgets(
          swiperWidget.children, buildContext),
      "count": swiperWidget.count,
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    return CategoryWidget(
      children: DynamicWidgetBuilder.buildWidgets(
          map['children'], buildContext, listener),
      count: map['itemCount'],
    );
  }

  @override
  String get widgetName => 'CategoryWidget';

  @override
  Type get widgetType => CategoryWidget;
}

class CategoryWidget extends StatefulWidget {
  final int count;
  final List<Widget> children;

  CategoryWidget({required this.count, required this.children});

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Wrap(
        children: [
          ...widget.children
              .map((e) => Container(
                    width: constraints.maxWidth / widget.count,
                    child: e,
                  ))
              .toList()
        ],
      ); // create function here to adapt to the parent widget's constraints
    });
  }
}
