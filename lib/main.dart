import 'package:flutter/material.dart';

void main() {
  ///全局更新：启动时调用后不会再调用
  runApp(MyApp());
}

///一切都是Widget，Widget其实并不是表示最终绘制在设备屏幕上的显示元素，而它只是描述显示元素的一个配置数据
///Flutter中真正代表屏幕上显示元素的类是 Element，也就是说Widget 只是描述 Element 的配置数据。并且一个 Widget
///可以对应多个 Element，因为同一个 Widget 对象可以被添加到 UI树的不同部分，而真正渲染时，UI树的每一个 Element
///节点都会对应一个 Widget 对象。
///StatelessWidget 无状态的
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ///整个APP的根布局
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        /// 主题颜色
        primarySwatch: Colors.red,
      ),

      ///界面的根布局
      home: MyHomePage(title: 'Blend Demo'),
    );
  }
}

// Flutter 生命周期的整个过程可以分为四个阶段
//
// 初始化阶段：createState 和 initState
// 组件创建阶段：didChangeDependencies 和 build
// 触发组件 build：didChangeDependencies、setState 或者didUpdateWidget 都会引发的组件重新 build
// 组件销毁阶段：deactivate 和 dispose

///StatefulWidget : 有状态的Widget，存在中间状态变化的widget
class MyHomePage extends StatefulWidget {
  /// 这里表示Key是可空的,title必须传入,这是可选命名参数
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  /// 在构造函数中传入的title
  final String title;

  ///createState()：创建State对象，可能创建多次,前面加上_,表示私有
  ///createState() 用于创建和StatefulWidget相关的状态
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

///State的两个重要属性：{@link _MyHomePageState#build(BuildContext)}这个方法
///widget：表示与该State实例关联的widget实例
///context：BuildContext的一个实例
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // 该函数为 State 初始化调用，因此可以在此期间执行 State 各变量的初始赋值，
  // 同时也可以在此期间与服务端交互，获取服务端数据后调用 setState 来设置 State。
  @override
  void initState() {
    print('initState');
    super.initState();
  }

  // 当State对象的依赖发生变化时会被调用；例如：在之前build() 中包含了一个InheritedWidget，
  // 然后在之后的build() 中InheritedWidget发生了变化，那么此时InheritedWidget的子widget的
  // didChangeDependencies()回调都会被调用。典型的场景是当系统语言Locale或应用主题改变时，
  // Flutter framework会通知widget调用此回调。
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  // 在 debug 模式下，每次热重载都会调用该函数，因此在 debug 阶段可以在此期间增加一些 debug 代码，来检查代码问题。
  @override
  void reassemble() {
    print('reassemble1');
    super.reassemble();
  }

  // 在widget重新构建时，Flutter framework会调用Widget.canUpdate来检测Widget树中同一位置的新旧节点，
  // 然后决定是否需要更新，如果Widget.canUpdate返回true则会调用此回调。正如之前所述，Widget.canUpdate会
  // 在新旧widget的key和runtimeType同时相等时会返回true，也就是说在在新旧widget的key和runtimeType同时
  // 相等时didUpdateWidget()就会被调用。父组件发生 build 的情况下，子组件该方法才会被调用，其次该方法调用
  // 之后一定会再调用本组件中的 build 方法。
  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }

  // 在组件被移除节点后会被调用，如果该组件被移除节点，然后未被插入到其他节点时，则会继续调用 dispose 永久移除。
  @override
  void deactivate() {
    super.deactivate();
    print('deactivate');
  }

  // 永久移除组件，并释放组件资源。
  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }

  void _incrementCounter() {
    ///局部子树更新：将子树作StatefulWidget的一个字Widget，并创建对应的State类实例，
    ///通过调用State.setState()触发子树的刷新。
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  // 主要是返回需要渲染的 Widget ，由于 build 会被调用多次，因此在该函数中只能做返回 Widget
  // 相关逻辑，避免因为执行多次导致状态异常。
  @override
  Widget build(BuildContext context) {
    print('build');
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    ///脚手架：通常包含标题栏和主体，相当于界面的根布局
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        /// 这个widget的title就是从MyHomePage对象中获取的，然后设置为标题
        title: Text(widget.title),
      ),

      /// body是一个居中布局
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        ///列布局
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          ///主轴方向居中
          mainAxisAlignment: MainAxisAlignment.center,

          ///儿子们
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        ///点击事件
        onPressed: _incrementCounter,

        ///长按提示
        tooltip: 'Increment',

        ///FloatingActionButton的图标
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
