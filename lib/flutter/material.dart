import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 是一个`String`类型的属性，用于设置整个应用程序的标题。
      title: 'MaterialApp',
      // 初始化路由,是一个hashmap,表示的路由表,{}里面的key是路由名称，value是一个函数，返回一个Widget
      routes: {'/other': (BuildContext context) => OtherPage()},
//      initialRoute: '/other',
      // 初始界面
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // 定义了一个数组，数组中的每个元素都是一个Text Widget
  final _widgetOptions = [
    Text('信息'),
    Text('通讯录'),
    Text('发现'),
    Text('我'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 是一个`Widget`类型的属性，用于设置当前界面所显示的标题栏。
        title: Text('MaterialApp示例'),
        // 标题居中
        centerTitle: true,
        // 左侧图标
        leading: Icon(Icons.home),
        //阴影
        elevation: 10.0,
        // 右侧图标
        actions: [
          Icon(Icons.search),
          Icon(Icons.more_vert),
        ],
      ),
      body: Center(
        // 是一个`Widget`类型的属性，用于设置当前界面所显示的主要内容区域。
        // 该属性通常使用`Column`或`ListView`来设置。
        child: _widgetOptions.elementAt(_currentIndex),
      ),

      // FloatingActionButton是一个悬浮按钮，点击后会执行onPressed方法中的代码
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 路由跳转
          Navigator.pushNamed(context, '/other');
        },
        tooltip: '路由跳转',
        // 前景色
        foregroundColor: Colors.lime,
        // 背景色
        backgroundColor: Colors.red,
        //阴影
        elevation: 10.0,
        child: Icon(Icons.arrow_forward),
        //改成方形
        shape: RoundedRectangleBorder(),
      ),
      // FloatingActionButton的位置
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      // 底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        items: [
          // 底部导航栏的按钮
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: '信息',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: '通讯录',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.near_me),
            label: '发现',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '我',
          ),
        ],
        // 当前选中的按钮
        currentIndex: _currentIndex,
        // 导航栏类型
        type: BottomNavigationBarType.fixed,
        // 点击事件
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class OtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OtherPage'),
      ),
    );
  }
}
