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
  Animation<double>? _widgetAnim;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5))
          ..forward();
    _widgetAnim = Tween(begin: 0.0, end: 1.0).animate(_animationController!)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController?.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController?.forward();
        }
      });
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
        child: MyLogo(
          animation: _widgetAnim!,
        ),
      ),
    );
  }
}

// `AnimatedWidget`类，用于在Flutter中创建动画效果。它是一个抽象类，继承自`StatefulWidget`，
// 并且提供了一些默认实现。
// 使用`AnimatedWidget`时，需要创建一个继承自`AnimatedWidget`的子类，并且实现`build`方法。`build`方法会
// 在动画状态发生变化时被调用，用于构建动画效果。
class MyLogo extends AnimatedWidget {
  //旋转
  final Tween<double> _rotateAnim = Tween<double>(begin: 0.0, end: 20.0);

  //放大缩小
  final Tween<double> _scaleAnim = Tween<double>(begin: 1.0, end: 10.0);

  // `Listenable`是一个抽象类，实现了一个"观察者模式"，
  // `listenable`通常是一个`Animation`对象，它会在动画的值发生变化时通知`AnimatedWidget`进行重建
  // 也就是调用build方法
  MyLogo({Key? key, @required Animation? animation})
      : super(key: key, listenable: animation!);

  @override
  Widget build(BuildContext context) {
    // 获取到`Animation`对象
    final Animation<double> animation = listenable as Animation<double>;
    print(_scaleAnim.evaluate(animation));
    // 因为build会不断的刷新，所以animation值会不断的变化
    return Transform.scale(
      // 参数：
      // - `animation`：一个 `Animation<double>` 类型的对象，表示要计算值的动画。
      // 返回值：
      // - `T`：根据Tween的类型和配置计算得到的值,也就是动画的值。
      // 将计算的值,应用到scale上
      scale: _scaleAnim.evaluate(animation),
      // 用于对其子部件进行旋转
      child: Transform.rotate(
        angle: _rotateAnim.evaluate(animation),
        child: Container(
          child: FlutterLogo(),
        ),
      ),
    );
  }
}
