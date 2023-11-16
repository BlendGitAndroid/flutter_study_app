import 'package:flutter/material.dart';
import 'package:flutter_study_app/practice/inherited/name_game/welcome_sub.dart';

import '../widget/name_inherited_widget.dart';

/// 欢迎人展示组件
class Welcome extends StatelessWidget {
  /// 有状态类返回组件信息
  @override
  Widget build(BuildContext context) {
    print('welcome build');

    // 通过context.dependOnInheritedWidgetOfExactType进行注册,用于从父组件获取共享数据
    final name =
        (context.dependOnInheritedWidgetOfExactType<NameInheritedWidget>()
                as NameInheritedWidget)
            .name;

    return Column(
      children: [
        Text('欢迎 $name'),
        WelcomeSub(),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
