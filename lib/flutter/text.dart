import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(TextApp());

class TextApp extends StatelessWidget {
  const TextApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Text示例'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Flutter 是 Google 推出并开源的移动应用开发框架，主打跨平台、高保真、高性能。开发者可以通过 Dart 语言开发 App，'
                '一套代码同时运行在 iOS 和 Android平台。',
                maxLines: 1,
                overflow: TextOverflow.ellipsis, //小点
                softWrap: true, //自动换行
                style: TextStyle(
                    fontSize: 30.0,
                    decoration: TextDecoration.lineThrough,
                    decorationStyle: TextDecorationStyle.wavy),
              ),
              SizedBox(
                height: 100.0,
              ),
              RichText(
                text: TextSpan(
                  text: 'Flutter 提供了丰富的组件、接口，',
                  style: TextStyle(color: Colors.deepOrange, fontSize: 20.0),
                  // RichText还有子孩子
                  children: <TextSpan>[
                    TextSpan(
                      text: '开发者可以很快地为',
                      style:
                          TextStyle(color: Colors.deepPurple, fontSize: 20.0),
                    ),
                    TextSpan(
                        text: 'Flutter 添加 Native 扩展。', //
                        style:
                            TextStyle(color: Colors.tealAccent, fontSize: 20.0),
                        recognizer: TapGestureRecognizer()
                          //..操作符，级联，返回的对象还是自己，就像StringBuffer的级联
                          // 这里还用到了匿名函数
                          ..onTap = () async {
                            String url = 'https://www.baidu.com/';
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url));
                            } else {
                              throw 'error: $url';
                            }
                          }

                          // 这里也是匿名函数,将后面的函数对象赋值给onTapDown
                          // 因为onTapDown是一个函数对象，所以可以这样写
                          ..onTapDown = (TapDownDetails details) {
                            print('onTapDown');
                          }
                          // 也可以这样写
                          ..onTapDown = (details) => print('onTapDown')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
