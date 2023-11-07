import 'dart:math';

import 'package:flutter/material.dart';

import '../name_game/random_name.dart';
import '../name_game/test_other.dart';
import '../name_game/welcome.dart';
import '../widget/name_inherited_widget.dart';

/// 测试随机名字游戏组件
class NameGame extends StatefulWidget {
  /// 构造函数
  const NameGame({Key? key}) : super(key: key);

  @override
  createState() => NameGameState();
}

/// 需要使用 NameGameState 方法来封装组件，如果该子组件直接写在 build 中的 child 方法中，
/// 就无法利用 NameInheritedWidget 优点，这点大家要特别注意。
class NameGameState extends State<NameGame> {
  /// name 状态
  String? name;

  /// 构造函数参数，避免父组件状态变化，而引起的子组件的重 build 操作
  Widget? child;

  /// 修改当前名字
  void changeName() {
    List<String> nameList = ['flutter one', 'flutter two', 'flutter three'];
    int pos = Random().nextInt(3);
    setState(() {
      name = nameList[pos];
    });
  }

  @override
  void initState() {
    child = Column(children: <Widget>[
      Welcome(),
      RandomName(),
      // 如果 TestOther 是 NameInheritedWidget 的子组件，那么在执行 setState 后，
      // NameInheritedWidget 会判断状态是否有状态变化，还会判断子组件是否有依赖该 name 状态，从而就保证了两点：
      // 状态变化时，如果未使用该状态子组件，则不会发生 build；
      // 使用了该状态组件，如果组件的状态没有发生变化，也不会发生 build。
      TestOther(),
    ]);

    setState(() {
      name = 'test flutter';
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("NameGame build");
    return Column(
      children: <Widget>[
        // 将被共享的数据,包括在NameInheritedWidget中
        NameInheritedWidget(
            child: child!, onNameChange: changeName, name: name!),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    print("NameGame Dependencies change");
    super.didChangeDependencies();
  }
}
