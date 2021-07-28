import 'dart:core';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class AnimateTextWidgetParser implements WidgetParser {
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    return AnimatedTextKit(
        pause: Duration(milliseconds: map['pause']),
        totalRepeatCount: map['totalRepeatCount'],
        repeatForever: map['repeatForever'],
        animatedTexts: parseAnimatedTextes(
            List<Map<String, dynamic>>.from(map['animatedTexts'])));
  }

  @override
  String get widgetName => "AnimatedTextKit";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    AnimatedTextKit realWidget = widget as AnimatedTextKit;
    return <String, dynamic>{
      "type": "AnimatedTextKit",
      "pause": realWidget.pause.inMilliseconds,
      "totalRepeatCount": realWidget.totalRepeatCount,
      "repeatForever": realWidget.repeatForever,
      "animatedTexts": exportAnimatedTextes(realWidget.animatedTexts),
    };
  }

  @override
  Type get widgetType => AnimatedTextKit;

  @override
  bool matchWidgetForExport(Widget? widget) => widget is AnimatedTextKit;
}

List<Map<String, dynamic>> exportAnimatedTextes(
    List<AnimatedText> animatedTexts) {
  List<Map<String, dynamic>> rt = [];
  animatedTexts.forEach((element) {
    if (element.runtimeType == ColorizeAnimatedText) {
      rt.add(<String, dynamic>{
        "type": element.runtimeType.toString(),
        "data": element.text,
        "colors": exportColorList((element as ColorizeAnimatedText).colors),
        "style": exportTextStyle(element.textStyle),
        "textAlign": element.textAlign != null
            ? exportTextAlign(element.textAlign)
            : "start",
        "duration": element.duration.inMilliseconds,
      });
    } else {
      rt.add(<String, dynamic>{
        "type": element.runtimeType.toString(),
        "data": element.text,
        "colors": null,
        "style": exportTextStyle(element.textStyle),
        "textAlign": element.textAlign != null
            ? exportTextAlign(element.textAlign)
            : "start",
        "duration": element.duration.inMilliseconds,
      });
    }
  });

  return rt;
}

List<AnimatedText> parseAnimatedTextes(
    List<Map<String, dynamic>> animatedTexts) {
  List<AnimatedText> rt = [];
  animatedTexts.forEach((element) {
    switch (element['type']) {
      case 'ColorizeAnimatedText':
        rt.add(new ColorizeAnimatedText(element['data'],
            textStyle: parseTextStyle(element['textStyle']) ??
                new TextStyle(fontSize: 14),
            textAlign: parseTextAlign(element['textAlign']),
            speed: Duration(milliseconds: element['duration']),
            colors: parseColorList(element['colors']) ??
                [Colors.purple, Colors.blue, Colors.yellow, Colors.red]));
        break;
      case 'RotateAnimatedText':
        rt.add(new RotateAnimatedText(
          element['data'],
          textStyle: parseTextStyle(element['textStyle']) ??
              new TextStyle(fontSize: 14),
          duration: Duration(milliseconds: element['duration']),
          textAlign: parseTextAlign(element['textAlign']),
        ));
        break;
      case 'FadeAnimatedText':
        rt.add(new FadeAnimatedText(
          element['data'],
          textStyle: parseTextStyle(element['textStyle']) ??
              new TextStyle(fontSize: 14),
          duration: Duration(milliseconds: element['duration']),
          textAlign: parseTextAlign(element['textAlign']),
        ));
        break;
      case 'TyperAnimatedText':
        rt.add(new TyperAnimatedText(
          element['data'],
          textStyle: parseTextStyle(element['textStyle']) ??
              new TextStyle(fontSize: 14),
          speed: Duration(milliseconds: element['duration']),
          textAlign: parseTextAlign(element['textAlign']),
        ));
        break;
      case 'TypewriterAnimatedText':
        rt.add(new TypewriterAnimatedText(
          element['data'],
          textStyle: parseTextStyle(element['textStyle']) ??
              new TextStyle(fontSize: 14),
          speed: Duration(milliseconds: element['duration']),
          textAlign: parseTextAlign(element['textAlign']),
        ));
        break;
      case 'ScaleAnimatedText':
        rt.add(new ScaleAnimatedText(
          element['data'],
          textStyle: parseTextStyle(element['textStyle']) ??
              new TextStyle(fontSize: 14),
          duration: Duration(milliseconds: element['duration']),
          textAlign: parseTextAlign(element['textAlign']),
        ));
        break;
      case 'WavyAnimatedText':
        rt.add(new WavyAnimatedText(
          element['data'],
          textStyle: parseTextStyle(element['textStyle']) ??
              new TextStyle(fontSize: 14),
          speed: Duration(milliseconds: element['duration']),
          textAlign: parseTextAlign(element['textAlign']),
        ));
        break;
      case 'FlickerAnimatedText':
        rt.add(new FlickerAnimatedText(
          element['data'],
          textStyle: parseTextStyle(element['textStyle']) ??
              new TextStyle(fontSize: 14),
          speed: Duration(milliseconds: element['duration']),
          textAlign: parseTextAlign(element['textAlign']),
        ));
        break;
    }
  });

  return rt;
}
