import 'package:flutter/material.dart';

class ShakePage extends StatefulWidget {
  @override
  _ShakePageState createState() => _ShakePageState();
}

class _ShakePageState extends State<ShakePage> {
  bool isShake = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('摇一摇'),
      ),
      body: Center(
        child: Column(
          //Column居中显示
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/ic_shake.png',
              width: 120.0,
              height: 120.0,
            ),
            //间隔
            SizedBox(
              height: 10.0,
            ),
            Text('摇一摇获取礼品'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: '礼品'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: '资讯')
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          if (!mounted) return;
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
