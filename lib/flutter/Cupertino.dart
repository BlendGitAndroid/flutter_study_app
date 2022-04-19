import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CupertinoApp',
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
    // return tabScaffold();
    // return alertDialog();
    return progressIndicator();
  }

  Scaffold progressIndicator() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Android风格
            CircularProgressIndicator(
              strokeWidth: 5,
            ),
            SizedBox(
              height: 150.0,
            ),
            //iOS风格
            CupertinoActivityIndicator(
              radius: 15.0,
            ),
          ],
        ),
      ),
    );
  }

  Scaffold alertDialog() {
    return Scaffold(
      body: Center(
        child: CupertinoAlertDialog(
          title: Text('标题'),
          content: Text('aaaa'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('确定'),
            ),
            CupertinoDialogAction(
              child: Text('取消'),
            ),
          ],
        ),
      ),
    );
  }

  CupertinoTabScaffold tabScaffold() {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '主页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: '消息',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            switch (index) {
              case 0:
                return MyHome();
              case 1:
                return MyMessage();
              default:
                return MyHome();
            }
          },
        );
      },
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('主页'),
        leading: Icon(CupertinoIcons.back),
        trailing: Icon(CupertinoIcons.search),
      ),
      child: Center(
        child: CupertinoButton(
          child: Text('主页'),
          color: Color(0xff0000ff),
          onPressed: () {},
        ),
      ),
    );
  }
}

class MyMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('消息'),
        leading: Icon(CupertinoIcons.back),
        trailing: Icon(CupertinoIcons.search),
      ),
      child: Center(
        child: CupertinoButton(
          child: Text('消息'),
          color: Color(0xff0000ff),
          onPressed: () {},
        ),
      ),
    );
  }
}
