import 'package:flutter/material.dart';

import '../widget/name_inherited_widget.dart';

/// 随机展示人名
class RandomName extends StatelessWidget {
  /// 有状态类返回组件信息
  @override
  Widget build(BuildContext context) {
    print('random name build');

    // 获取共享数据
    final String name =
        (context.dependOnInheritedWidgetOfExactType<NameInheritedWidget>()
                as NameInheritedWidget)
            .name;

    // 获取共享方法
    final Function changeName =
        (context.dependOnInheritedWidgetOfExactType<NameInheritedWidget>()
                as NameInheritedWidget)
            .onNameChange;

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        alignment: Alignment.center,
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          name,
          style: TextStyle(fontSize: 20),
        ),
      ),
      onTap: () => changeName(),
    );
  }
}
