import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation<Color?>? _doubleAnim;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..forward();

    // `ColorTween`是Flutter中的一个类，用于在两个颜色之间进行插值。它可以用于创建一个在指定时间范围内从一个颜色过渡到另一个颜色的动画。
    // `ColorTween`继承自`Tween`类，`Tween`类是一个用于在两个值之间进行插值的类。`ColorTween`特定于颜色值，并且针对颜色之间的插值提供了一些便利方法。
    _doubleAnim = ColorTween(begin: Colors.red, end: Colors.white)
        .animate(_animationController!)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        // 如果已经完成
        if (status == AnimationStatus.completed) {
          _animationController?.reverse();
        } else if (status == AnimationStatus.dismissed) {
          //如果回到初始状态
          _animationController?.forward();
        }
      });
    _animationController?.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200.0,
          height: 200.0,
          color: _doubleAnim?.value,
          // 一个Flutter内置的小部件，用于显示Flutter的标志
          child: FlutterLogo(),
        ),
      ),
    );
  }
}
