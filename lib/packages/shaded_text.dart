import 'package:flutter/material.dart';

//方法定义
typedef ShadeBuilder = Widget Function(
    BuildContext context, String text, Color color);

class ShadedText extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color shadeColor;
  final double? xTans;
  final double? yTans;
  final ShadeBuilder shadeBuilder;

  const ShadedText(
      {Key? key,
      required this.text,
      required this.textColor,
      required this.shadeColor,
      this.xTans,
      this.yTans,
      required this.shadeBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        shadeBuilder(context, text, textColor),
        Transform(
          transform: Matrix4.translationValues(xTans ?? 10, yTans ?? 10, 0),
          child: shadeBuilder(context, text, shadeColor),
        ),
      ],
    );
  }
}
