import 'package:flutter/material.dart';
import 'package:flutter_study_app/practice/my_provider/provider_route.dart';

/// APP 核心入口文件
void main() {
  runApp(MyApp());
}

/// MyApp 核心入口界面
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Provider Demo', // APP 名字
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue, // APP 主题
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('My Provider Demo'), // 页面名字
            ),
            body: Center(
              child: ProviderRoute(),
            )));
  }
}
