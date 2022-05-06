import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../constants/constants.dart';
import '../utils/data_utils.dart';

class PublishTweetPage extends StatefulWidget {
  @override
  _PublishTweetPageState createState() => _PublishTweetPageState();
}

class _PublishTweetPageState extends State<PublishTweetPage> {
  TextEditingController _controller = new TextEditingController();
  List<File> fileList = [];
  Future<XFile?>? _imageFile;
  bool isLoading = false;

  //输入框
  Widget _bodyWidget() {
    List<Widget> _body = [
      ListView(
        children: <Widget>[
          //动弹内容输入框
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                  hintText: '今天想动弹什么?',
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
          //图片显示 ListView嵌套GradView
          GridView.count(
            shrinkWrap: true,
            //每一行显示4个
            crossAxisCount: 4,
            children: List.generate(
              //默认的+号icon
              fileList.length + 1,
              (index) {
                //默认第一个icon
                if (index == fileList.length) {
                  return Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          //选择图片
                          _pickImage(context);
                        },
                        child: Image.asset(
                          'assets/images/ic_add_pics.png',
                        ),
                      );
                    },
                  );
                }
                return GestureDetector(
                  //点击事件
                  onTap: () {
                    //取消图片
                    setState(() {
                      fileList.removeAt(index);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(
                      fileList[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
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
                  Text('努力动弹中...', style: TextStyle(color: Colors.white))
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
          '弹一弹',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          Builder(
            builder: (context) {
              return TextButton(
                onPressed: () {
                  //发布动弹
                  DataUtils.getAccessToken().then((token) {
                    //网络请求，发布动弹
                    _publishTweet(context, token);
                  });
                },
                child: Text(
                  '发送',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              );
            },
          )
        ],
      ),
      //类似于网络请求的Builder
      body: FutureBuilder(
        future: _imageFile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null &&
              _imageFile != null) {
            if (snapshot.data is XFile) {
              fileList.add(File((snapshot.data as XFile).path));
            } else {
              _showSnackBar(context, "图片选择失败");
            }
            _imageFile = null;
          }
          return _bodyWidget();
        },
      ),
    );
  }

  //发送动弹
  void _publishTweet(BuildContext context, String? token) async {
    if (token == null) {
      _showSnackBar(context, '未登录！');
      return;
    }
    //拿到输入框的文本信息
    String tweetContent = _controller.text;
    if (tweetContent.isEmpty) {
      //未输入动弹内容
      _showSnackBar(context, '请输入动弹内容！');
      return;
    }
    Map<String, String> params = new Map();
    params['msg'] = tweetContent;
    params['access_token'] = token;
    print('动弹内容：$tweetContent');

    var multipartRequest =
        http.MultipartRequest('POST', Uri.parse(AppUrls.TWEET_PUB));
    multipartRequest.fields.addAll(params);
    if (fileList.length > 0) {
      for (File file in fileList) {
        var stream = new http.ByteStream(file.openRead());
        var length = await file.length();
        print("图片地址：" + '${file.path}');
        var fileName = file.path.substring(file.path.lastIndexOf('/') + 1);
        // MultipartFile(this.field, Stream<List<int>> stream, this.length,
        //{this.filename, MediaType contentType})
        multipartRequest.files
            .add(http.MultipartFile('img', stream, length, filename: fileName));
      }
    }
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
            fileList.clear();
            _controller.clear();
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

  //选择添加图片
  void _pickImage(BuildContext context) {
    // 如果已添加了9张图片，则提示不允许添加更多
    num size = fileList.length;
    if (size >= 9) {
      _showSnackBar(context, "最多只能添加9张图片！");
      return;
    }
    //底部弹出框（相机拍照和选择照片）
    showModalBottomSheet<void>(
        context: context,
        builder: (context) {
          return new Container(
              height: 121.0,
              child: new Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      if (mounted) {
                        setState(() {
                          _imageFile = ImagePicker()
                              .pickImage(source: ImageSource.camera);
                        });
                      }
                    },
                    child: Container(
                      height: 60.0,
                      child: Center(
                        child: Text(
                          '相机拍照',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                  new Divider(
                    height: 1.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      if (mounted) {
                        setState(() {
                          _imageFile = ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                        });
                      }
                    },
                    child: Container(
                      height: 60.0,
                      child: Center(
                        child: Text(
                          '图库选择照片',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}
