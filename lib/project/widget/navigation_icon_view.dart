import 'package:flutter/material.dart';

class NavigationIconView {
  //item，用于在底部导航栏中显示的每个项目的组件
  final BottomNavigationBarItem item;

  //title
  final String title;

  //icon path
  final String iconPath;

  //activeIcon icon path
  final String activeIconPath;

  NavigationIconView(
      {required this.title,
      required this.iconPath,
      required this.activeIconPath})
      : item = BottomNavigationBarItem(
            icon: Image.asset(
              iconPath,
              width: 20.0,
              height: 20.0,
            ),
            activeIcon: Image.asset(
              activeIconPath,
              width: 20.0,
              height: 20.0,
            ),
            label: title);
}
