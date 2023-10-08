import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_study_app/project/pages/profile_detail_page.dart';

import '../common/event_bus.dart';
import '../constants/constants.dart';
import '../utils/data_utils.dart';
import '../utils/net_utils.dart';
import 'log_web_page.dart';
import 'my_message_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List menuTitles = [
    '我的消息',
    '阅读记录',
    '我的博客',
    '我的问答',
    '我的活动',
    '我的团队',
    '邀请好友',
  ];
  List menuIcons = [
    Icons.message,
    Icons.print,
    Icons.error,
    Icons.phone,
    Icons.send,
    Icons.people,
    Icons.person,
  ];

  String? userAvatar;
  String? userName;

  @override
  void initState() {
    super.initState();
    //尝试显示用户信息
    _showUerInfo();
    eventBus.on<LoginEvent>().listen((event) {
      //获取用户信息并显示
      _getUerInfo();
    });
    eventBus.on<LogoutEvent>().listen((event) {
      _showUerInfo();
    });
  }

  _getUerInfo() {
    DataUtils.getAccessToken().then((accessToken) {
      if (accessToken == null || accessToken.length == 0) {
        return;
      }

      Map<String, dynamic> params = Map<String, dynamic>();
      params['access_token'] = accessToken;
      params['dataType'] = 'json';
      print('accessToken: $accessToken');
      NetUtils.get(AppUrls.OPENAPI_USER, params).then((data) {
        print('openapi user data: $data');
        Map<String, dynamic> map = json.decode(data);
        if (mounted) {
          setState(() {
            userAvatar = map['avatar'];
            userName = map['name'];
          });
        }
        DataUtils.saveUserInfo(map);
      });
    });
  }

  _showUerInfo() {
    DataUtils.getUserInfo().then((user) {
      if (mounted) {
        setState(() {
          if (user != null) {
            userAvatar = user.avatar;
            userName = user.name;
          } else {
            userAvatar = null;
            userName = null;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          // 头部
          if (index == 0) {
            return _buildHeader();
          }
          // 减去头部,所以要减去1
          index -= 1;
          return ListTile(
            leading: Icon(menuIcons[index]),
            title: Text(menuTitles[index]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              DataUtils.isLogin().then((isLogin) {
                if (isLogin) {
                  switch (index) {
                    case 0:
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MyMessagePage()));
                      break;
                    case 2:
                      eventBus.fire(GotoBlogEvent());
                      break;
                  }
                } else {
                  _login();
                }
              });
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: menuTitles.length + 1);
  }

  _login() async {
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginWebPage()));
    if (result != null && result == AppConstants.LOGIN_WEB_REFRESH) {
      //登录成功
      eventBus.fire(LoginEvent());
    }
  }

  Container _buildHeader() {
    return Container(
      height: 150.0,
      color: AppColors.APP_THEME,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //头像
            GestureDetector(
              child: userAvatar != null
                  ? Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // 通过装饰器,将这里设置成圆形
                        border: Border.all(
                          color: Color(0xffffffff),
                          width: 2.0,
                        ),
                        image: DecorationImage(
                          // 从网络获取图片
                          image: NetworkImage(userAvatar!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Image.asset(
                      'assets/images/ic_avatar_default.png',
                      width: 60.0,
                      height: 60.0,
                    ),
              onTap: () {
                DataUtils.isLogin().then((isLogin) {
                  if (isLogin) {
                    //详情
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfileDetailPage()));
                  } else {
                    //执行登录
                    _login();
                  }
                });
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              userName ??= '点击头像登录',
              style: TextStyle(color: Color(0xffffffff)),
            ),
            //用户名
          ],
        ),
      ),
    );
  }
}
