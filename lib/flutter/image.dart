import 'dart:io';
import 'dart:typed_data';

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

              ///从文件中加载
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

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _file = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          onPressed: getImage,
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
