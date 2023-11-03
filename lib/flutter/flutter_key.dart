import 'package:flutter/material.dart';

void main() => runApp(KeyApp());

class KeyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: GestureDetector(
            onTap: () {
              print('Parent onTap');
            },
            onTapDown: (details) {
              print('Parent onTapDown');
            },
            onTapUp: (details) {
              print('Parent onTapUp');
            },
            child: Column(
              children: [
                // 有key和没有key的区别
                MyBox(color: Colors.blue, key: ValueKey(1)),
                MyBox(color: Colors.yellow, key: ValueKey(2)),
                MyBox(color: Colors.green, key: ValueKey(3))
                // MyBox(color: Colors.yellow),
                // MyBox(color: Colors.blue),
                // MyBox(color: Colors.green)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyBox extends StatefulWidget {
  final Color? color;
  final Key? key;

  MyBox({this.color, this.key}) : super(key: key);

  @override
  _MyBoxState createState() => _MyBoxState();
}

class _MyBoxState extends State<MyBox> {
  num number = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('onTap');
        setState(() {
          number++;
        });
      },
      onTapDown: (details) {
        print('onTapDown');
      },
      onTapUp: (details) {
        print('onTapUp');
      },
      child: Container(
        alignment: Alignment.center,
        width: 60,
        height: 60,
        color: widget.color,
        child: Text(
          number.toString(),
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
