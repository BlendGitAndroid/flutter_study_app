import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

//Interval :延时动画
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Tween<double>? _tween;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5))
          ..repeat();
    _tween = Tween<double>(begin: 0.0, end: 1.0);
  }

  Animation<double>? get animOne => _tween?.animate(
        CurvedAnimation(
          parent: _animationController!,
          curve: Interval(
            0.0,
            0.125,
            curve: Curves.linear,
          ),
        ),
      );

  Animation<double>? get animTwo => _tween?.animate(
        CurvedAnimation(
          parent: _animationController!,
          curve: Interval(
            0.125,
            0.25,
            curve: Curves.linear,
          ),
        ),
      );

  Animation<double>? get animThree => _tween?.animate(
        CurvedAnimation(
          parent: _animationController!,
          curve: Interval(
            0.25,
            0.375,
            curve: Curves.linear,
          ),
        ),
      );

  Animation<double>? get animFour => _tween?.animate(
        CurvedAnimation(
          parent: _animationController!,
          curve: Interval(
            0.375,
            0.5,
            curve: Curves.linear,
          ),
        ),
      );

  Animation<double>? get animFive => _tween?.animate(
        CurvedAnimation(
          parent: _animationController!,
          curve: Interval(
            0.5,
            0.625,
            curve: Curves.linear,
          ),
        ),
      );

  Animation<double>? get animSix => _tween?.animate(
        CurvedAnimation(
          parent: _animationController!,
          curve: Interval(
            0.625,
            0.75,
            curve: Curves.linear,
          ),
        ),
      );

  Animation<double>? get animSeven => _tween?.animate(
        CurvedAnimation(
          parent: _animationController!,
          curve: Interval(
            0.75,
            0.875,
            curve: Curves.linear,
          ),
        ),
      );

  Animation<double>? get animEight => _tween?.animate(
        CurvedAnimation(
          parent: _animationController!,
          curve: Interval(
            0.875,
            1.0,
            curve: Curves.linear,
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _animationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new AnimatedBrick(
              animations: [animOne!, animTwo!],
              controller: _animationController!,
              marginLeft: 0.0,
              alignment: Alignment.centerLeft,
              isClockWise: true,
              key: ObjectKey(1),
            ),
            new AnimatedBrick(
              animations: [animThree!, animEight!],
              controller: _animationController!,
              marginLeft: 0.0,
              isClockWise: false,
              key: ObjectKey(2),
            ),
            new AnimatedBrick(
              animations: [animFour!, animSeven!],
              controller: _animationController!,
              marginLeft: 30.0,
              isClockWise: true,
              key: ObjectKey(3),
            ),
            new AnimatedBrick(
              animations: [animFive!, animSix!],
              controller: _animationController!,
              marginLeft: 30.0,
              isClockWise: false,
              key: ObjectKey(4),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedBrick extends AnimatedWidget {
  final AnimationController controller;
  final List<Animation> animations;
  final double marginLeft;
  final Alignment alignment;
  final bool isClockWise;

  AnimatedBrick({
    required Key key,
    required this.controller,
    required this.animations,
    required this.marginLeft,
    this.alignment = Alignment.centerRight,
    required this.isClockWise,
  }) : super(key: key, listenable: controller);

  Matrix4 clockWise(animation) =>
      Matrix4.rotationZ(animation.value * pi * 2.0 * 0.5);

  Matrix4 antiClockWise(animation) =>
      Matrix4.rotationZ(-(animation.value * pi * 2.0 * 0.5));

  @override
  Widget build(BuildContext context) {
    var firstTransformation =
        isClockWise ? clockWise(animations[0]) : antiClockWise(animations[0]);
    var secondTransformation =
        isClockWise ? clockWise(animations[1]) : antiClockWise(animations[1]);

    return Transform(
        alignment: alignment,
        transform: firstTransformation,
        child: Transform(
            alignment: alignment,
            transform: secondTransformation,
            child: BrickWidget(
              marginLeft: marginLeft,
              key: ObjectKey(5),
            )));
  }
}

class BrickWidget extends StatelessWidget {
  final double marginLeft;

  const BrickWidget({
    required Key key,
    this.marginLeft = 15.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: marginLeft),
      width: 40.0,
      height: 10.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Color(0xffff0000),
      ),
    );
  }
}
