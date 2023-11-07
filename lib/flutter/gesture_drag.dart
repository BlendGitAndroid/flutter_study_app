import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      // home: ButtonGesture(),
      home: GestureDrag(),
    ));

class GestureDrag extends StatefulWidget {
  @override
  _DragState createState() => _DragState();
}

class _DragState extends State<GestureDrag>
    with SingleTickerProviderStateMixin {
  double _top = 50.0; //距顶部的偏移
  double _left = 50.0; //距左边的偏移

  double _radius = 30; //圆的半径

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('手势拖动'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: _top,
            left: _left,
            // 通过GestureDetector对CircleAvatar进行手势操作
            child: GestureDetector(
              child: CircleAvatar(child: Text("A"), radius: _radius),
              //手指按下时会触发此回调,会有一个DragDownDetails 回调
              onPanDown: (DragDownDetails e) {
                //打印手指按下的位置(相对于屏幕)
                print("用户手指按下：${e.globalPosition}");
              },
              //手指滑动时会触发此回调
              onPanUpdate: (DragUpdateDetails e) {
                //用户手指滑动时，更新偏移，重新构建
                setState(() {
                  _left += e.delta.dx;
                  _top += e.delta.dy;
                });
              },
              onPanEnd: (DragEndDetails e) {
                //打印滑动结束时在x、y轴上的速度
                print(e.velocity);
              },
            ),
          )
        ],
      ),
    );
  }
}
