import 'package:flutter/material.dart';
import 'package:flutter_study_app/practice/inherited/pages/name_game.dart';

import 'inheritedwidget.dart';

/// APP 核心入口文件
void main() {
  runApp(MyApp());
}
/// 数据共享（InheritedWidget）使用总结:
/// 正常情况下,页面刷新通过3个方法,setState,didChangeDependencies和didUpdateWidget.如果一个页面
/// 的build方法被调用,那么它的子页面的didUpdateWidget和Build会相继被调用.即使这个子页面数据没有改变,
/// 也会被重新渲染.虽然这是没有必要的.
/// 在InheritedWidget的情况下,父子组件共享一个数据源,这里还要分两种情况:
/// 1)InheritedWidget的child使用变量.
///   a.子组件注册依赖关系,共享数据的改变,子组件会didChangeDependencies和build
///   b.子组件没有注册以来关系,共享数据的改变,子组件什么都不会触发
/// 2)InheritedWidget的child没有使用变量.
///   a.子组件注册依赖关系,子组件会didUpdateWidget,didChangeDependencies和build
///   b.子组件没有注册以来关系,和没有使用InheritedWidget一样
/// 所以InheritedWidget应该是最少使用原则,共享数据的组件在一起,没有共享的,就不要使用InheritedWidget了.

/// MyApp 核心入口界面
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'InheritedWidget使用的两个Demo', // APP 名字
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue, // APP 主题
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('InheritedWidget使用的两个Demo'), // 页面名字
            ),
            body: Center(
              // child: NameGame(),
              child: InheritedWidgetTestRoute(),
            )));
  }
}
