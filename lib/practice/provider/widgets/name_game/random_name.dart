import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/name_model.dart';

/// 随机展示人名
class RandomName extends StatelessWidget {
  /// 有状态类返回组件信息
  @override
  Widget build(BuildContext context) {
    // 获取到全局的NameModel
    final _name = Provider.of<NameModel>(context);

    print('random name build');
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
          _name.value,
          style: TextStyle(fontSize: 20),
        ),
      ),
      onTap: () => _name.changeName(),
    );
  }
}
