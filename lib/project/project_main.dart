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
        primarySwatch: AppColors.APP_THEME,
      ),
      home: ProjectHomePage(),
    );
  }
}
