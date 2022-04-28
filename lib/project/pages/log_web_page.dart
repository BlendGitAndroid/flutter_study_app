import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants/constants.dart';
import '../utils/data_utils.dart';
import '../utils/net_utils.dart';

class LoginWebPage extends StatefulWidget {
  const LoginWebPage({Key? key}) : super(key: key);

  @override
  _LoginWebPageState createState() => _LoginWebPageState();
}

class _LoginWebPageState extends State<LoginWebPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "登录开源中国",
            style: TextStyle(color: AppColors.APPBAR),
          ),
          iconTheme: IconThemeData(color: AppColors.APPBAR),
        ),
        body: WebView(
          initialUrl: AppUrls.OAUTH2_AUTHORIZE +
              '?response_type=code&client_id=' +
              AppInfos.CLIENT_ID +
              '&redirect_uri=' +
              AppInfos.REDIRECT_URI,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            //监听url
            if (request.url.contains('?code=')) {
              print('navigationDelegate navigation to $request}');
              //登录成功了
              //提取授权码code
              String code =
                  request.url.split('?')[1].split('&')[0].split('=')[1];
              Map<String, dynamic> params = Map<String, dynamic>();
              params['client_id'] = AppInfos.CLIENT_ID;
              params['client_secret'] = AppInfos.CLIENT_SECRET;
              params['grant_type'] = 'authorization_code';
              params['redirect_uri'] = AppInfos.REDIRECT_URI;
              params['code'] = '$code';
              params['dataType'] = 'json';
              NetUtils.get(AppUrls.OAUTH2_TOKEN, params).then((data) {
                print('navigationDelegate oauth2_token: $data');
                Map<String, dynamic> map = json.decode(data);
                if (map.isNotEmpty) {
                  //保存token等信息
                  DataUtils.saveLoginInfo(map);
                  //弹出当前路由，并返回refresh通知我的界面刷新数据
                  Navigator.pop(context, AppConstants.LOGIN_WEB_REFRESH);
                }
              });
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ));
  }
}
