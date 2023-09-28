import 'dart:math';

import 'package:flutter/material.dart';

//点击旋转
void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation<double>? _animation;
  AnimationController? _animationController;
  bool reversed = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    // `TweenSequence`是Flutter中的一个类，用于创建一个由多个`Tween`组成的序列动画。
    //
    // `TweenSequence`类的构造函数接受一个`List`类型的参数，其中每个元素都是`Tween`对象。
    // 每个`Tween`对象定义了一个动画的起始值和结束值，并且可以指定曲线类型和插值器。
    _animation = TweenSequence([
      // `TweenSequenceItem`是Flutter中`TweenSequence`的一个辅助类，用于定义`Tween`序列中的每个动画项。
      // `TweenSequenceItem`类有两个属性：
      // - `tween`：指定一个`Tween`对象，用于定义动画项的起始值和结束值。
      // - `weight`：指定动画项的权重，用于控制动画项的持续时间。权重值是一个0.0到1.0之间的浮点数，表示动画项所占整个序列动画的比例。
      TweenSequenceItem(
        //从0到-90度
        tween: Tween(begin: 0.0, end: -pi / 2),
        weight: 0.5,
      ),
      TweenSequenceItem(
        //从90度到0
        tween: Tween(begin: pi / 2, end: 0.0),
        weight: 0.5,
      ),
    ]).animate(_animationController!);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController?.dispose();
  }

  _doAnim() {
    reversed
        ? _animationController?.reverse()
        : _animationController?.forward();
    reversed = !reversed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
            animation: _animation!,
            builder: (BuildContext context, Widget? child) {
              return Transform(
                transform: Matrix4.identity() //创建一个4维的矩阵
                  ..setEntry(3, 2,
                      0.001) //将矩阵的第3行第2列设置为0.001。作用是类似设置物体到摄像机的距离，越远物体看起来越小，越近看起来物体越大
                  ..rotateY(_animation?.value ?? 0),
                alignment: Alignment.center,
                // 手势监听
                child: GestureDetector(
                  // 点击旋转
                  onTap: _doAnim,
                  // 根据索引值决定显示哪一个子组件，并将其放置在堆叠布局中。
                  child: IndexedStack(
                    children: <Widget>[
                      CardOne(),
                      CardTwo(),
                    ],
                    // 组件的对齐方式
                    alignment: Alignment.center,
                    //通过index控制翻转显示的页面
                    index:
                        (_animationController?.value ?? 0) < 0.5 ? 0 : 1, //0~1
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class CardOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffff0000),
      child: Container(
        width: 200.0,
        height: 200.0,
        child: Text(
          '点我看密码',
          style: TextStyle(color: Color(0xffffffff), fontSize: 30.0),
        ),
      ),
    );
  }
}

class CardTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xff0000ff),
      child: Container(
        width: 200.0,
        height: 200.0,
        child: Text(
          '123456',
          style: TextStyle(color: Color(0xffffffff), fontSize: 30.0),
        ),
      ),
    );
  }
}
