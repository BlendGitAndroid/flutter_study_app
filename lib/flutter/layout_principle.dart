import 'package:flutter/material.dart';

void main() => runApp(ContainerApp());

/// 向下传递约束,向上传递大小
class ContainerApp extends StatelessWidget {
  const ContainerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return layout1();
    // return layout2();
    return layout3();
  }

  // 加上Scaffold，布局正常了
  MaterialApp layout3() {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          width: 300,
          height: 300,
          color: Colors.amber,
          alignment: Alignment.center,
          child: Container(
            width: 50,
            height: 50,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  // 加上alignment属性，子组件正常显示了，但容器还是铺满全屏。
  Container layout2() {
    return Container(
      width: 300,
      height: 300,
      color: Colors.amber,
      alignment: Alignment.center,
      child: Container(
        width: 50,
        height: 50,
        color: Colors.red,
      ),
    );
  }

  // 背景是一个红色的,布满整个屏幕的Container
  Container layout1() {
    return Container(
      width: 300,
      height: 300,
      color: Colors.amber,
      child: Container(
        width: 50,
        height: 50,
        color: Colors.red,
      ),
    );
  }
}
