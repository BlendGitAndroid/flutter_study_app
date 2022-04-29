import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants/constants.dart';

class CommonWebPage extends StatefulWidget {
  final String title;
  final String url;

  const CommonWebPage({required this.title, required this.url, Key? key})
      : super(key: key);

  @override
  _CommonWebPageState createState() => _CommonWebPageState();
}

class _CommonWebPageState extends State<CommonWebPage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            widget.title,
            style: TextStyle(color: AppColors.APPBAR),
          ),
          iconTheme: IconThemeData(color: AppColors.APPBAR),
        ),
        body: Stack(
          children: [
            WebView(
              initialUrl: widget.url,
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
            ),
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
}
