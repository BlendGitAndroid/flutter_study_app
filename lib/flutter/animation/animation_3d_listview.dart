import 'package:flutter/material.dart';

//这个效果可以做成画廊
void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var images = [
    'lib/flutter/images/ic_fu.png',
    'lib/flutter/images/ic_fu.png',
    'lib/flutter/images/ic_fu.png',
    'lib/flutter/images/ic_fu.png',
    'lib/flutter/images/ic_fu.png',
    'lib/flutter/images/ic_fu.png',
    'lib/flutter/images/ic_fu.png',
    'lib/flutter/images/ic_fu.png',
    'lib/flutter/images/ic_fu.png',
    'lib/flutter/images/ic_fu.png',
    'lib/flutter/images/ic_fu.png',
    'lib/flutter/images/ic_fu.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      //3D效果，滚轮效果
      child: ListWheelScrollView(
        perspective: 0.003,
        diameterRatio: 2.0,
        //修改显示高度，为屏幕高度*0.6
        itemExtent: MediaQuery.of(context).size.height * 0.6,
        children: images
            .map((m) => Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  //类似于FrameLayout
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image.asset(
                        m,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 30.0,
                        left: 30.0,
                        child: Text(
                          '中国福',
                          style: TextStyle(
                              color: Colors.deepOrange, fontSize: 30.0),
                        ),
                      )
                    ],
                  ),
                ))
            .toList(),
      ),
    ));
  }
}
