import 'package:flutter/material.dart';

//动画分为：补间动画和物理动画

// `Animation`是一个表示动画的抽象类，而`AnimationController`则是控制动画的类。

// `AnimationController`是Flutter中的一个类，用于控制动画的播放和管理动画的状态。它是`Animation`的一个具体实现，
// 可以用来控制动画的进度和持续时间。
// `AnimationController`的常用属性和方法包括：
// - `value`：一个`double`类型的值，表示动画的当前值，范围在0.0到1.0之间。
// - `duration`：一个`Duration`类型的值，表示动画的持续时间。
// - `vsync`：一个`TickerProvider`类型的值，用于提供动画刷新的时钟信号。
// - `forward()`：启动动画，从当前值向前播放到1.0。
// - `reverse()`：反向播放动画，从当前值向后播放到0.0。
// - `repeat()`：循环播放动画，从当前值向前播放到1.0，然后反向播放到0.0，如此反复。
// - `addListener()`：添加一个回调函数，可以在动画的值发生变化时被调用。
// - `dispose()`：释放资源，停止动画并清除所有监听器。
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
  String? _animValue;

  //补间动画的四种状态
  //1 dismissed 初始状态
  //2 forward 从头到尾播放状态
  //3 reverse 从尾到头播放状态
  //4 completed 完成状态

  @override
  void initState() {
    super.initState();
    //初始化
    // 这里的this,就是`Ticker`对象是用来监听屏幕刷新的定时器，它的工作是在每一帧绘制之前调用注册的回调函数。
    // `TickerProvider`用于创建和管理`Ticker`对象，并将其提供给需要监听屏幕刷新的组件或动画。
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10));
    // 补间动画: `Tween`是Flutter中的一个类，用于创建动画的插值器。它定义了一个从起始值到结束值的变化范围，
    // 并根据动画的进度计算出中间值。
    _doubleAnim = Tween(begin: 0.0, end: 1.0).animate(_animationController!)
      //在动画的值发生变化时被调用
      ..addListener(() {
        print("addListener $_doubleAnim");
        setState(() {
          //保留两位小数
          _animValue = _doubleAnim?.value.toStringAsFixed(2);
        });
      })
      //监听状态的改变
      ..addStatusListener((status) {
        print("addStatusListener $status");
      });
  }

  @override
  void dispose() {
    super.dispose();
    //释放掉
    _animationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(_animValue ??= '0.0'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _animationController?.forward(from: 0.0);
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
