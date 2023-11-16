import 'package:flutter/material.dart';
import 'package:flutter_study_app/practice/provider/widgets/name_game/welcome_sub.dart';
import 'package:provider/provider.dart';

import '../../model/name_model.dart';

/// 欢迎人展示组件
class Welcome extends StatelessWidget {
  /// 有状态类返回组件信息
  @override
  Widget build(BuildContext context) {

    // 通过 Provider.of(context) 方式，获得根节点 NameModel 的句柄，然后通过 NameModel 的 value 获得状态 name 的值
    final _nameModule = Provider.of<NameModel>(context);

    print('welcome build');
    return Column(
      children: [
        Text('欢迎 ${_nameModule.value}'),
        WelcomeSub(),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
