import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5))
          ..forward();
    _doubleAnim = Tween(begin: 0.0, end: 1.0).animate(_animationController!)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController?.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController?.forward();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MyLogo(
          animation: _doubleAnim!,
        ),
      ),
    );
  }
}

class MyLogo extends AnimatedWidget {
  //旋转
  final Tween<double> _rotateAnim = Tween<double>(begin: 0.0, end: 20.0);

  //放大缩小
  final Tween<double> _scaleAnim = Tween<double>(begin: 1.0, end: 10.0);

  MyLogo({Key? key, @required Animation? animation})
      : super(key: key, listenable: animation!);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Transform.scale(
      scale: _scaleAnim.evaluate(animation),
      child: Transform.rotate(
        angle: _rotateAnim.evaluate(animation),
        child: Container(
          child: FlutterLogo(),
        ),
      ),
    );
  }
}
