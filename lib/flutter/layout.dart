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
      floatingActionButton: FloatingActionButton(
          child: Text('点击'),
          onPressed: () {
            setState(() {
              _index = (++_index) % 2;
            });
          }),
    );
  }

  //动态显示和不显示
  IndexedStack buildIndexedStack() {
    // 根据索引值决定显示哪一个子组件，并将其放置在堆叠布局中。
    return IndexedStack(
      index: _index,
      // `Alignment`是一个用于指定水平和垂直方向上对齐方式的类。它在Flutter中常用于布局相关
      // 的小部件中，如`Container`、`Align`等。
      // `Alignment`的常用属性包括：
      // - `x`：一个`double`值，表示水平方向上的对齐方式。取值范围为-1.0到1.0之间，
      // 其中-1.0表示左对齐，0.0表示居中对齐，1.0表示右对齐。
      // - `y`：一个`double`值，表示垂直方向上的对齐方式。取值范围为-1.0到1.0之间，
      // 其中-1.0表示顶部对齐，0.0表示居中对齐，1.0表示底部对齐。
      alignment: Alignment(1.2, -1.2),
      children: <Widget>[
        Container(
          color: Color(0xff0000ff),
          width: 200.0,
          height: 200.0,
        ),
        // 通过`CircleAvatar`可以很方便的实现一个圆形头像样式的小部件。
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
      //定义子组件的对齐方式，中间就是0.0的位置，右上角是（1，-1），再偏移就是（1.2，-1.2）
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
    // 一个用于堆叠多个子组件的布局小部件。它允许将多个子组件放置在一起，并可以控制它们的堆叠顺序、位置和尺寸
    return Stack(
      children: <Widget>[
        Container(
          color: Color(0xffff0000),
          width: 200.0,
          height: 200.0,
        ),
        // 绝对布局
        Positioned(
          top: 10.0,
          right: 10.0,
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
