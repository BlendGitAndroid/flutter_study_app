import 'package:flutter/material.dart';

class InheritedWidgetTestRoute extends StatefulWidget {
  const InheritedWidgetTestRoute({Key? key}) : super(key: key);

  @override
  _InheritedWidgetTestRouteState createState() =>
      _InheritedWidgetTestRouteState();
}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int count = 0;

  Widget? child;  // 缓存住,构造函数参数，避免父组件状态变化，而引起的子组件的重 build 操作

  @override
  void initState() {
    child = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: _TestWidget(), //子widget中依赖ShareDataWidget
        ),
        ElevatedButton(
          child: const Text("Increment"),
          //每点击一次，将count自增，然后重新build,ShareDataWidget的data将被更新
          onPressed: () => setState(() => ++count),
        )
      ],
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    print("InheritedWidgetTestRoute build");
    return Center(
      //使用ShareDataWidget
      child: ShareDataWidget(
        data: count,
        child: child!,
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   print("InheritedWidgetTestRoute build");
  //   return Center(
  //     //使用ShareDataWidget
  //     child: ShareDataWidget(
  //       data: count,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Padding(
  //             padding: const EdgeInsets.only(bottom: 20.0),
  //             child: _TestWidget(), //子widget中依赖ShareDataWidget
  //           ),
  //           ElevatedButton(
  //             child: const Text("Increment"),
  //             //每点击一次，将count自增，然后重新build,ShareDataWidget的data将被更新
  //             onPressed: () => setState(() => ++count),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

class ShareDataWidget extends InheritedWidget {
  const ShareDataWidget({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  final int data; //需要在子树中共享的数据，保存点击次数

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ShareDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
    // return context
    //     .getElementForInheritedWidgetOfExactType<ShareDataWidget>()
    //     ?.widget as ShareDataWidget;
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget
  @override
  bool updateShouldNotify(ShareDataWidget old) {
    return old.data != data;
  }
}

class _TestWidget extends StatefulWidget {
  @override
  __TestWidgetState createState() => __TestWidgetState();
}

class __TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    print("_TestWidget build build");
    //使用InheritedWidget中的共享数据
    // return Text(ShareDataWidget.of(context)!.data.toString());
    return Text("text"); // 这样,点击的话,didChangeDependencies,就不会被调用,但是Build方法还是会调用的,为了不使Build调用,需要缓存,看上面
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print("didChangeDependencies didChangeDependencies");
  }

  @override
  void didUpdateWidget(covariant _TestWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget didUpdateWidget");
  }
}
