import 'package:flutter/material.dart';

import 'constants/constants.dart';
import 'home_page.dart';

void main() => runApp(MyApp());

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
