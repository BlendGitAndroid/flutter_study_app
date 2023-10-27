import 'package:flutter/material.dart';

import '../widget/name_inherited_widget.dart';

/// 欢迎人展示组件
class Welcome extends StatelessWidget {
  /// 有状态类返回组件信息
  @override
  Widget build(BuildContext context) {
    print('welcome build');
    final name = (context.dependOnInheritedWidgetOfExactType<NameInheritedWidget>()
            as NameInheritedWidget)
        .name;

    return Text('欢迎 $name');
  }
}
