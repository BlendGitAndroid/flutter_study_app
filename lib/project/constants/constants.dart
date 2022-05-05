import 'package:flutter/material.dart';

abstract class AppColors {
  //应用主题色
  static const APP_THEME = Colors.green;
  static const APPBAR = Colors.white;
  static const APP_GRAY = Color(0xffaaaaaa);
}

abstract class AppInfos {
  static const String CLIENT_ID = 'NmzYoHEkuQp5P7QqtrjO'; //应用id
  static const String CLIENT_SECRET = 'ym1c7EL9bitFVo44GtT9XFZ4fbvbgfUX'; //应用密钥
  static const String REDIRECT_URI =
      'https://juejin.cn/user/782508011039869'; //回调地址
}

abstract class AppUrls {
  static const String HOST = 'https://www.oschina.net';

  //授权登录
  static const String OAUTH2_AUTHORIZE = HOST + '/action/oauth2/authorize';

  //获取token
  static const String OAUTH2_TOKEN = HOST + '/action/openapi/token';

  //获取用户信息
  static const String OPENAPI_USER = HOST + '/action/openapi/user';

  //个人主页详情
  static const String MY_INFORMATION = HOST + '/action/openapi/my_information';

  //获取私信列表
  static const String MESSAGE_LIST = HOST + '/action/openapi/message_list';

  //新闻列表
  static const String NEWS_LIST = HOST + '/action/openapi/news_list';

  //获取新闻详情
  static const String NEWS_DETAIL = HOST + '/action/openapi/news_detail';

  //获取动弹列表 （最新动弹列表 我的动弹）
  static const String TWEET_LIST = HOST + '/action/openapi/tweet_list';

  //发布动弹
  static const String TWEET_PUB = HOST + '/action/openapi/tweet_pub';
}

abstract class AppConstants {
  static const String LOGIN_WEB_REFRESH = "login_web_refresh";
}
