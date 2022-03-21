import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class SwiperWidgetParser extends WidgetParser {
  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext) {
    SwiperWidget swiperWidget = widget as SwiperWidget;
    return <String, dynamic>{
      "type": "SwiperWidget",
      "children": DynamicWidgetBuilder.exportWidgets(
          swiperWidget.params.children!, buildContext),
      "itemCount": swiperWidget.params.itemCount,
      "itemWidth": swiperWidget.params.itemWidth,
      "layout": swiperWidget.params.layout != null
          ? swiperWidget.params.layout!.index.toInt()
          : 0,
      "viewportFraction": swiperWidget.params.viewportFraction,
      "autoplay": swiperWidget.params.autoplay,
      "pagination": swiperWidget.params.pagination,
      "scale": swiperWidget.params.scale
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    return SwiperWidget(
      SwiperParams(
          pagination: map['pagination'],
          children: DynamicWidgetBuilder.buildWidgets(
              map['children'], buildContext, listener),
          itemCount: map['itemCount'],
          itemWidth: map['itemWidth'],
          layout: SwiperLayout.values[map['layout']],
          viewportFraction: map['viewportFraction'],
          autoplay: map['autoplay'],
          scale: map['scale']),
    );
  }

  @override
  String get widgetName => 'SwiperWidget';

  @override
  Type get widgetType => SwiperWidget;
}

class SwiperWidget extends StatefulWidget {
  final SwiperParams params;

  SwiperWidget(this.params);

  @override
  _SwiperWidgetState createState() => _SwiperWidgetState(params);
}

class _SwiperWidgetState extends State<SwiperWidget> {
  SwiperParams params;
  List<Widget?> _items = [];
  bool isPerformingRequest = false;

  //If there are no more items, it should not try to load more data while scroll
  //to bottom.
  bool loadCompleted = false;

  _SwiperWidgetState(this.params) {
    if (params.children != null) {
      _items.addAll(params.children!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (context, index) {
        return params.children != null ? params.children![index] : Container();
      },
      itemCount: params.children!.length,
      itemWidth: params.itemWidth ?? 200,
      layout: params.layout,
      customLayoutOption: new CustomLayoutOption(startIndex: -1, stateCount: 3)
          .addRotate([-25.0 / 180, 0.0, 25.0 / 180]).addTranslate([
        new Offset(-370.0, -40.0),
        new Offset(0.0, 0.0),
        new Offset(370.0, -40.0)
      ]),
      viewportFraction: params.viewportFraction ?? 0.5,
      autoplay: params.autoplay ?? false,
      pagination: params.pagination
          ? new SwiperPagination(
              builder: const DotSwiperPaginationBuilder(
                  size: 10.0, activeSize: 10.0, space: 5.0))
          : null,
      scale: params.scale,
    );
  }
}

class SwiperParams {
  int? itemCount;
  double? itemWidth;
  SwiperLayout? layout;
  double? viewportFraction;
  bool? autoplay;
  bool pagination;
  List<Widget>? children;
  double? scale;

  SwiperParams(
      {this.itemCount,
      this.itemWidth,
      this.layout,
      this.viewportFraction,
      this.autoplay,
      required this.pagination,
      this.scale,
      this.children});
}
