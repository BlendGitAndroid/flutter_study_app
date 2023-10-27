import 'package:flutter/material.dart';
import 'package:flutter_study_app/practice/provider/model/name_model.dart';
import 'package:provider/provider.dart';

import '../widgets/name_game/random_name.dart';
import '../widgets/name_game/test_other.dart';
import '../widgets/name_game/welcome.dart';

/// 测试随机名字游戏组件
class NameGame extends StatelessWidget {
  /// 设置状态 name
  final name = NameModel();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Provider<String>.value(
          value: '我是测试数据',
          child: ChangeNotifierProvider.value(
            value: name,
            child: Column(
              children: <Widget>[
                Welcome(),
                RandomName(),
              ],
            ),
          ),
        ),
        TestOther(),
      ],
    );
  }
}
