import 'package:flutter/material.dart';

/// 定义一个name共享父组件
class NameInheritedWidget extends InheritedWidget {
  /// 共享状态
  final String name;

  /// 修改共享状态方法
  final Function onNameChange;

  /// 构造函数
  NameInheritedWidget({
    Key? key,
    required Widget child,
    required this.name,
    required this.onNameChange,
  }) : super(key: key, child: child);

  // 该回调决定当data发生变化时，是否通知子树中依赖data的Widget重新build
  @override
  bool updateShouldNotify(NameInheritedWidget old) {
    print(name != old.name);
    return name != old.name;
  }
}
