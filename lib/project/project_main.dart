import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_study_app/project/utils/report.dart';

import 'constants/constants.dart';
import 'home_page.dart';

// 在事件循环中，当某个任务发生异常并没有被捕获时，程序并不会退出，而直接导致的结果
// 是当前任务的后续代码就不会被执行了，也就是说一个任务中的异常是不会影响其他任务执行的。
// 应用发生异常,并不会崩溃,因为是单线程和事件驱动机制,只会造成这个事件不执行
// void main() => runApp(MyApp());

void main() {
  // runZoned(
  //   () => runApp(MyApp()),
  //   zoneSpecification: ZoneSpecification(
  //     // 拦截print打印
  //     print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
  //       parent.print(zone,"print打印");
  //       parent.print(zone, line);
  //     },
  //     // 拦截未处理的异步错误
  //     handleUncaughtError: (Zone self, ZoneDelegate parent, Zone zone,
  //         Object error, StackTrace stackTrace) {
  //       parent.print(zone,"handleUncaughtError错误");
  //       parent.print(zone, '${error.toString()} $stackTrace');
  //     },
  //   ),
  // );

  Report.start();

  // 其他异常捕获
  runZonedGuarded(() => runApp(MyApp()), (error, stack) {
    print("runZonedGuarded error: $error");
    print("runZonedGuarded stack: $stack");
  });

  // Flutter框架异常捕获:提供一个自定义的错误处理回调即可,就是复写FlutterError.onError的默认实现
  FlutterError.onError = (FlutterErrorDetails details) {
    print("FlutterError.onError: $details");
  };

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //去掉右上角debug标签
      title: '开源中国',
      theme: ThemeData(
        primaryColor: AppColors.APP_THEME,
        // 主题颜色的一个"样本色"，通过这个样本色可以在一些条件下生成一些其他的属性，
        // 例如，如果没有指定primaryColor，并且当前主题不是深色主题，那么primaryColor就会
        // 默认为primarySwatch指定的颜色
        primarySwatch: AppColors.APP_THEME,
      ),
      home: ProjectHomePage(),
    );
  }
}
