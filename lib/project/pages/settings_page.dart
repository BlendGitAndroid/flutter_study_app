import 'package:flutter/material.dart';

import '../common/event_bus.dart';
import '../constants/constants.dart';
import '../utils/data_utils.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          '设置',
          style: TextStyle(color: AppColors.APPBAR),
        ),
        iconTheme: IconThemeData(color: AppColors.APPBAR),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              //退出登录
              DataUtils.clearLoginInfo().then((_) {
                eventBus.fire(LogoutEvent());
                Navigator.of(context).pop();
              });
            },
            child: Text(
              '退出登录',
              style: TextStyle(fontSize: 25.0),
            )),
      ),
    );
  }
}
