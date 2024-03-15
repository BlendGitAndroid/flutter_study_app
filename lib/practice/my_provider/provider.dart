import 'package:flutter/widgets.dart';

// 通过封装一个StatefulWidget，将子Widget树缓存起来
// ChangeNotifierProvider是InheritedWidget的封装
// ChangeNotifier类,是一个发布者-订阅者模式
class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {

  final Widget child;
  final T data;

  const ChangeNotifierProvider({
    Key? key,
    // 需要共享的数据
    required this.data,
    required this.child,
  }) : super(key: key);

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static T? of<T>(BuildContext context, {bool listen = true}) {
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()
        : context
            .getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()
            ?.widget as InheritedProvider<T>;
    return provider?.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() =>
      _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {

  void update() {
    //如果数据发生变化（model类调用了notifyListeners），就会调用update方法,重新构建InheritedProvider
    setState(() => {});
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    print("_ChangeNotifierProviderState didUpdateWidget");
    //当Provider更新时，如果新旧数据不"=="，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除model的监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("_ChangeNotifierProviderState build");
    // 数据使用InheritedProvider包裹,data就是共享的数据
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}

// 一个通用的InheritedWidget，保存需要跨组件的共享数据
class InheritedProvider<T> extends InheritedWidget {

  const InheritedProvider({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  final T data;

  @override
  bool updateShouldNotify(oldWidget) {
    //在此简单返回true，则每次更新都会调用依赖其的子孙节点的`didChangeDependencies`。
    return true;
  }
}

// 这是一个便捷类，会获得当前context和指定数据类型的Provider
class Consumer<T> extends StatelessWidget {
  const Consumer({
    Key? key,
    required this.builder,
  }) : super(key: key);

  // 定义一个builder函数,该函数返回一个Widget
  final Widget Function(BuildContext context, T? value) builder;

  @override
  Widget build(BuildContext context) {
    print("Consumer build");
    return builder(
      context,
      ChangeNotifierProvider.of<T>(context, listen: true),
    );
  }
}
