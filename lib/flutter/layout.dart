import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      // home: StackApp(),
      home: TablePage(),
    ));

//表格布局
class TablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Table(
          //定义列的宽度
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(50.0),
            1: FixedColumnWidth(50.0),
            2: FixedColumnWidth(100.0),
            3: FixedColumnWidth(100.0),
          },
          //定义边框的颜色和宽度
          border: TableBorder.all(
            color: Color(0xffff0000),
            width: 2.0,
          ),
          //定义内容
          children: const <TableRow>[
            TableRow(children: [
              Text('图标'),
              Text('项目'),
              Text('技术'),
              Text('负责人'),
            ]),
            TableRow(children: [
              Icon(Icons.description),
              Text('淘宝'),
              Text('Android'),
              Text('程序员A'),
            ]),
            TableRow(children: [
              Icon(Icons.description),
              Text('京东'),
              Text('RN'),
              Text('程序员B'),
            ]),
            TableRow(children: [
              Icon(Icons.description),
              Text('微信'),
              Text('Flutter'),
              Text('程序员C'),
            ]),
          ],
        ),
      ),
    );
  }
}

//Stack：类似于FrameLayout
class StackApp extends StatefulWidget {
  const StackApp({Key? key}) : super(key: key);

  @override
  _StackAppState createState() => _StackAppState();
}

class _StackAppState extends State<StackApp> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: buildPositionedStack(),
        // child: buildAlignmentStack(),
        child: buildIndexedStack(),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          _index = (++_index) % 2;
        });
      }),
    );
  }

  //动态显示和不显示
  IndexedStack buildIndexedStack() {
    return IndexedStack(
      index: _index,
      alignment: Alignment(1.2, -1.2),
      children: <Widget>[
        Container(
          color: Color(0xff0000ff),
          width: 200.0,
          height: 200.0,
        ),
        CircleAvatar(
          radius: 30.0,
          backgroundColor: Color(0xffff0000),
        ),
      ],
    );
  }

  //偏移位置
  Stack buildAlignmentStack() {
    return Stack(
      //定义偏移位置，中间就是0.0的位置，右上角是（1，-1），再偏移就是（1.2，-1.2）
      alignment: Alignment(1.2, -1.2),
      children: <Widget>[
        Container(
          color: Color(0xff0000ff),
          width: 200.0,
          height: 200.0,
        ),
        CircleAvatar(
          radius: 20.0,
          backgroundColor: Color(0xffff0000),
        ),
      ],
    );
  }

  //绝对位置
  Stack buildPositionedStack() {
    return Stack(
      children: <Widget>[
        Container(
          color: Color(0xffff0000),
          width: 200.0,
          height: 200.0,
        ),
        Positioned(
//              top: 10.0,
          child: CircleAvatar(
            radius: 20.0,
            backgroundColor: Color(0xff0000ff),
          ),
        ),
      ],
    );
  }
}

class AlignApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Align(
            //设置定位方式
            alignment: Alignment.topRight,
            child: Container(
              width: 200.0,
              height: 200.0,
              color: Color(0xffff0000),
            ),
          ),
        ),
      ),
    );
  }
}
