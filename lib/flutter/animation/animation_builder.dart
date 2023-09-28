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
  Animation<double>? _doubleAnim;
  AnimationController? _animationController;

  //监听
  void myListener(status) {
    // 当动画完成时
    if (status == AnimationStatus.completed) {
      //将监听移除掉
      _doubleAnim?.removeStatusListener(myListener);
      // _animationController?.removeStatusListener(myListener);
      // 重置控制器
      _animationController?.reset();
      //Curve：定义了时间和数值的抽象类。Flutter封装定义了一系列的插值器，
      // 如linear、decelerate、ease、bounce、cubic等。当然Flutter提供的不满足需求的话，也可以自定义插值器。
      //Tween：线性估值器
      // `CurvedAnimation`是Flutter中的一个类，用于实现动画的曲线插值效果。它是`Animation`类的一个子类，
      // 可以接收一个`Animation`对象和一个曲线类型作为参数，并根据指定的曲线类型对传入的动画进行插值处理。
      // - `parent`参数是一个必需的`Animation`对象，表示要应用曲线插值的原始动画,其实就是将控制器传进去
      // - `curve`参数是一个必需的`Curve`对象，表示曲线类型，用于定义动画的速度变化。
      // 重新进行动画
      _doubleAnim = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _animationController!, curve: Curves.fastOutSlowIn));
      _animationController?.forward();
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _doubleAnim = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: _animationController!, curve: Curves.fastOutSlowIn))
      ..addStatusListener(myListener);
    _animationController?.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //屏幕宽度
    var _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // `AnimatedBuilder`是Flutter中的一个小部件，用于在动画过程中根据动画的当前值构建动画小部件。
      // 它能够高效地构建动画，避免不必要的重建，并提高性能。
      // - `animation`参数是一个必需的`Animation`对象，表示要监听的动画。
      // - `builder`参数是一个必需的回调函数，用于构建动画小部件。在每次动画值发生变化时，
      // `builder`函数将被调用，并传递`BuildContext`和`Widget`（可选）参数。根据这些参数，
      // 可以构建出带有动画效果的小部件，并返回给`AnimatedBuilder`。
      // - `child`参数是一个可选的小部件，将作为`builder`函数的第二个参数传递。如果没有子小部件，则可以将其设置为`null`。
      body: AnimatedBuilder(
          animation: _animationController!,
          builder: (BuildContext context, Widget? child) {
            return Transform(
              // `Matrix4.translationValues`是Flutter中的一个方法，用于创建一个表示平移变换的4x4矩阵。
              // 方法的定义如下：
              // - `x`参数表示在x轴上的平移距离。
              // - `y`参数表示在y轴上的平移距离。
              // - `z`参数表示在z轴上的平移距离。
              // 这个方法返回一个`Matrix4`对象，表示了平移变换。
              // 平移变换是一种将图形在平面上沿着指定的方向移动的变换。通过使用`Matrix4.translationValues`方法，
              // 可以创建一个平移变换的矩阵，然后应用于需要进行平移的对象上。
              // value的值从-1到0,-1*屏幕宽度就是在屏幕的左边,看不到了
              transform: Matrix4.translationValues(
                  (_doubleAnim?.value ?? 0) * _screenWidth, 0.0, 0.0),
              child: Center(
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  child: FlutterLogo(),
                ),
              ),
            );
          }),
    );
  }
}
