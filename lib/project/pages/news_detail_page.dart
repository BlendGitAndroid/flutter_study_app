import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants/constants.dart';
import '../utils/data_utils.dart';
import '../utils/net_utils.dart';

class NewsDetailPage extends StatefulWidget {
  final int id;

  const NewsDetailPage({required this.id, Key? key}) : super(key: key);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  String? url;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    DataUtils.getAccessToken().then((token) {
      Map<String, dynamic> params = Map<String, dynamic>();
      params['access_token'] = token;
      params['dataType'] = 'json';
      params['id'] = widget.id;
      NetUtils.get(AppUrls.NEWS_DETAIL, params).then((data) {
        if (data.isNotEmpty) {
          Map<String, dynamic> map = json.decode(data);
          print('NEWS_DETAIL: $map');
          if (!mounted) return;
          setState(() {
            url = map['url'];
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "资讯详情",
            style: TextStyle(color: AppColors.APPBAR),
          ),
          iconTheme: IconThemeData(color: AppColors.APPBAR),
        ),
        body: Stack(
          children: [
            url != null ? buildWebView() : Container(),
            isLoading
                ? Container(
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  )
                : Container(),
          ],
        ));
  }

  WebView buildWebView() {
    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
      onPageStarted: (String url) {
        setState(() {
          isLoading = true; // 开始访问页面，更新状态
        });
      },
      onPageFinished: (String url) {
        setState(() {
          isLoading = false; // 页面加载完成，更新状态
        });
      },
    );
  }
}
