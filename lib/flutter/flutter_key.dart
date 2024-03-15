import 'package:flutter/material.dart';

void main() => runApp(KeyApp());

class KeyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          // GestureDetector1 和 GestureDetector 2 会发生竞争，
          // 判定获胜的规则是“子组件优先”，所以 GestureDetector1 获胜，因为只能有一个“竞争者”胜出，所以 GestureDetector 2 将被忽略。
          // 命中测试后,会进行手势竞争
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
                MyBox(color: Colors.green, key: ValueKey(3)),
                // MyBox(color: Colors.yellow),
                // MyBox(color: Colors.blue),
                // MyBox(color: Colors.green)

                Container(
                  width: 100,
                  height: 100,
                  color: Colors.red)
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
  void initState() {
    print('MyBoxState initState');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MyBox oldWidget) {
    print('MyBoxState didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print('MyBoxState build');
    return GestureDetector(
      onTap: () {
        print('MyBoxState onTap');
        setState(() {
          number++;
        });
      },
      onTapDown: (details) {
        print('MyBoxState onTapDown');
      },
      onTapUp: (details) {
        print('MyBoxState onTapUp');
      },
      child: Container(
        alignment: Alignment.center,
        width: 60,
        height: 60,
        color: widget.color,
        child: Column(
          children: [
            // 区分有const和没有const的区别,如果只是子组件build不会触发ConstWidget重新build.
            // 但是如果父组件更新子组件build,didUpdateWidget方法便会被回调,会重新触发ConstWidget的build
            // ConstWidget(),
            const ConstWidget(),
            Text(
              number.toString(),
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class ConstWidget extends StatefulWidget {
  final Key? key;

  const ConstWidget({this.key}) : super(key: key);

  @override
  State<ConstWidget> createState() => _ConstWidgetState();
}

class _ConstWidgetState extends State<ConstWidget> {
  @override
  Widget build(BuildContext context) {
    print('ConstWidget build');
    return const Text("我是Const");
  }
}
