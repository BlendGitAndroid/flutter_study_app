import 'package:flutter/material.dart';

//动画分为：补间动画和物理动画
void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation<double>? _doubleAnim;
  AnimationController? _animationController;
  String? _animValue;

  //补间动画的四种状态
  //1 dismissed 初始状态
  //2 forward 从头到尾播放状态
  //3 reverse 从尾到头播放状态
  //4 completed 完成状态

  @override
  void initState() {
    super.initState();
    //初始化
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    //补间动画
    _doubleAnim = Tween(begin: 0.0, end: 1.0).animate(_animationController!)
      //监听值的改变
      ..addListener(() {
        print("addListener $_doubleAnim");
        setState(() {
          _animValue = _doubleAnim?.value.toString();
        });
      })
      //监听状态的改变
      ..addStatusListener((status) {
        print("addStatusListener $status");
      });
  }

  @override
  void dispose() {
    super.dispose();
    //释放掉
    _animationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(_animValue ??= '0.0'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _animationController?.forward(from: 0.0);
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
