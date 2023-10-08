import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../utils/data_utils.dart';

class PublishBlogPage extends StatefulWidget {
  @override
  _PublishBlogPageState createState() => _PublishBlogPageState();
}

class _PublishBlogPageState extends State<PublishBlogPage> {
  TextEditingController _controllerTitle = new TextEditingController();
  TextEditingController _controllerContent = new TextEditingController();
  bool isLoading = false;

  //输入框
  Widget _bodyWidget() {
    List<Widget> _body = [
      ListView(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Text("文章标题",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          // 博客标题输入框
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: TextField(
              controller: _controllerTitle,
              decoration: InputDecoration(
                  hintText: '请输入标题',
                  hintStyle: TextStyle(
                    color: Color(0xaaaaaaaa),
                  ),
                  //四周的边框及圆角
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  )),
              //最多字数显示，字数控制
              maxLength: 10,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Text("文章内容",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          //博客内容输入框
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: TextField(
              controller: _controllerContent,
              decoration: InputDecoration(
                  hintText: '今天想写点什么呢?',
                  hintStyle: TextStyle(
                    color: Color(0xaaaaaaaa),
                  ),
                  //四周的边框及圆角
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  )),
              //最多字数显示，字数控制
              maxLength: 150,
              maxLines: 6,
            ),
          ),
        ],
      )
    ];

    if (isLoading) {
      _body.add(
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
              color: Color(0x88000000),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CupertinoActivityIndicator(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('努力发布中...', style: TextStyle(color: Colors.white))
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Stack(
      children: _body,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false, //防止键盘弹出 导致超出屏幕
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          '写博客',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          Builder(
            builder: (context) {
              return TextButton(
                onPressed: () {
                  //发布博客
                  DataUtils.getAccessToken().then((token) {
                    //网络请求，发布博客
                    _publishBlog(context, token);
                  });
                },
                child: Text(
                  '发布文章',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              );
            },
          )
        ],
      ),
      body: Container(
        child: _bodyWidget(),
      ),
    );
  }

  //发送博客
  void _publishBlog(BuildContext context, String? token) async {
    if (token == null) {
      _showSnackBar(context, '未登录！');
      return;
    }
    //拿到内容输入框的文本信息
    String content = _controllerContent.text;
    String title = _controllerTitle.text;
    if (title.isEmpty) {
      //未输入博客标题
      _showSnackBar(context, '请输入博客标题！');
      return;
    }
    if (content.isEmpty) {
      //未输入博客内容
      _showSnackBar(context, '请输入博客内容！');
      return;
    }
    Map<String, String> params = new Map();
    params['access_token'] = token;
    params['title'] = title;
    params['classification'] = "1";
    params['content'] = content;

    var multipartRequest =
        http.MultipartRequest('POST', Uri.parse(AppUrls.BLOG_PUB));
    multipartRequest.fields.addAll(params);
    setState(() {
      isLoading = true;
    });
    print("发送的内容： " + multipartRequest.toString());
    var streamedResponse = await multipartRequest.send();
    streamedResponse.stream.transform(utf8.decoder).listen((response) {
      print('response: $response');
      setState(() {
        isLoading = false;
      });
      var decode = json.decode(response);
      var errorCode = decode['error'];
      if (mounted) {
        setState(() {
          if (errorCode != null && errorCode == '200') {
            _controllerContent.clear();
            _controllerTitle.clear();
            _showSnackBar(context, '发布成功!');
          } else {
            _showSnackBar(context, '发布失败: ${decode['error_description']}');
          }
        });
      }
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(message),
      duration: Duration(milliseconds: 500),
    ));
  }
}
