import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaterialApp',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dialog")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 上下选择框
            SimpleDialog(
              title: Text('对话框标题'),
              children: <Widget>[
                SimpleDialogOption(
                  child: Text('选项1'),
                  onPressed: () {
                    print('选项1');
                  },
                ),
                SimpleDialogOption(
                  child: Text('选项2'),
                  onPressed: () {
                    print('选项2');
                  },
                )
              ],
            ),
            ElevatedButton(
              child: Text('删除'),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('提示'),
                        // 包装单个子组件的小部件，它可以在需要滚动的情况下提供滚动功能。
                        content: SingleChildScrollView(
                          // `ListBody`是一个用于在垂直方向上排列子组件的小部件。
                          // 它会将其子组件放置在一个垂直的列表中，并根据需要自动调整每个
                          // 子组件的大小，使它们适应可用空间。
                          child: ListBody(
                            children: <Widget>[
                              Text('是否删除？'),
                              Text('删除后不可恢复！'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('确定'),
                            onPressed: () {
                              print("确定");
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('取消'),
                            onPressed: () {
                              print("取消");
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('忽略'),
                            onPressed: () {
                              print("忽略");
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
