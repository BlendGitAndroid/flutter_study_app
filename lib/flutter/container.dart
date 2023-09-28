import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(ContainerApp());

class ContainerApp extends StatelessWidget {
  const ContainerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 如果是无状态的组件，在home中，直接就是Scaffold组件
      // 这后面的都是组件，也就是一个类，那()里面的就是构造方法的参数
      home: Scaffold(
        appBar: AppBar(
          title: Text('Container Title'),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            width: 300,
            height: 200,
            // color: Colors.blue,不能同时定义，所以这里注释掉
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                color: Colors.amber,
                border: Border.all(color: Colors.blue, width: 10)),
            child: Text(
              'Container',
              style: TextStyle(fontSize: 28),
            ),
            transform: Matrix4.rotationZ(-pi / 9), //旋转，围绕Z轴旋转
          ),
        ),
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      )
    );
  }
}
