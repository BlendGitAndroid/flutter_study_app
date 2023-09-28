import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(ImageApp());

class ImageApp extends StatelessWidget {
  const ImageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              ///加载网路图片
              Image.network(
                'https://www.baidu.com/img/bd_logo1.png?where=super',
                width: 100,
                height: 100,
              ),

              ///本地加载
              Image.asset(
                'lib/flutter/images/ic_man.png',
                width: 100,
                height: 100,
              ),

              ///从内存中加载
              LoadFromMemoryWidget(),

              /// 这也就是为什么Flutter中的一切皆对象
              ///从文件中加载，就像实例化类一样，其实这个Widget就是一个类，类中有一个方法build，这个方法返回一个Widget
              LoadFromFileWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

///stf:StatefulWidget快捷键
///stl:StatelessWidget快捷键
class LoadFromMemoryWidget extends StatefulWidget {
  const LoadFromMemoryWidget({Key? key}) : super(key: key);

  @override
  _LoadFromMemoryWidgetState createState() => _LoadFromMemoryWidgetState();
}

class _LoadFromMemoryWidgetState extends State<LoadFromMemoryWidget> {
  Uint8List? bytes;

  @override
  void initState() {
    super.initState();
    rootBundle.load('lib/flutter/images/ic_fu.png').then((value) => {
          if (mounted)
            {
              setState(() {
                bytes = value.buffer.asUint8List();
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    final _decoration = BoxDecoration(
      image: bytes == null ? null : DecorationImage(image: MemoryImage(bytes!)),
    );
    return Container(
      width: 100,
      height: 100,
      decoration: _decoration,
    );
  }
}

class LoadFromFileWidget extends StatefulWidget {
  const LoadFromFileWidget({Key? key}) : super(key: key);

  @override
  _LoadFromFileWidgetState createState() => _LoadFromFileWidgetState();
}

class _LoadFromFileWidgetState extends State<LoadFromFileWidget> {
  XFile? _file;

  void _getImage() async {
    // 通过await等到异步操作的结果
    // 只要在async方法中，如果有返回值，那么返回值都是Future类型，且一定会有return，但是方法的return不需要写Future
    // 调用这个async方法，通过await获取返回到真正结果
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _file = image;
    });
  }

  // 上面的方法还可以这样写
  void _getImage2() {
    ImagePicker().pickImage(source: ImageSource.gallery).then((value) => {
          setState(() {
            _file = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // Column组件的children是一个数组，所以可以有多个子组件
      children: <Widget>[
        Center(
            child: _file == null
                ? Text("请选择图片")
                : Image.file(
                    File(_file?.path ?? ""),
                    width: 100,
                    height: 100,
                  )),
        ElevatedButton(
          onPressed: _getImage2,
          child: Text(
            '选择图片',
            style: TextStyle(
              color: Colors.amberAccent,
            ),
          ),
        ), //
      ],
    );
  }
}
