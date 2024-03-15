import 'dart:collection';

import 'package:flutter/material.dart';

import 'provider.dart';

// 自定义Provider需要解决的问题:
// 1. 共享数据保存,通过InheritedWidget共享数据
// 2. 数据发生变化,通过ChangeNotifier机制,调用notifyListeners来通知订阅者
class ProviderRoute extends StatefulWidget {
  const ProviderRoute({Key? key}) : super(key: key);

  @override
  _ProviderRouteState createState() => _ProviderRouteState();
}

class _ProviderRouteState extends State<ProviderRoute> {


  @override
  void didUpdateWidget(ProviderRoute oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("_ProviderRouteState didUpdateWidget");
  }

  @override
  Widget build(BuildContext context) {
    print("_ProviderRouteState build");
    return Center(
      child: ChangeNotifierProvider<CartModel>(
        data: CartModel(),
        child: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              // 自定义组件,获取购物车中商品总价,通过dependOnInheritedWidgetOfExactType来进行注册
              Consumer<CartModel>(
                // 给builder函数类型赋值,参数类型可省?
                builder: (BuildContext context, CartModel? cart) =>
                    Text("总价: ${cart!.totalPrice}"),
              ),
              // 通过Builder来构建ElevatedButton,这样可以获取到ChangeNotifierProvider的context
              // 在Flutter中，`Builder`是一个用于构建小部件树的小部件。它通常用于在某个上下文中构建小部件。
              // `Builder`被用于构建一个`ElevatedButton`小部件。
              // 使用`Builder`的主要原因是为了在当前上下文中创建新的上下文，通常是在需要访问父级上下文但又不想
              // 直接传递上下文参数的情况下。在上面的示例中，`ElevatedButton`可能需要访问父级上下文中的某些信息，
              // 但是又不希望直接传递`context`参数。因此，通过使用`Builder`，可以在`builder`函数中创建一个
              // 新的上下文，并在其中构建`ElevatedButton`。
              Builder(builder: (context) {
                print("ElevatedButton build");
                return ElevatedButton(
                  child: const Text("添加商品"),
                  onPressed: () {
                    var cart = ChangeNotifierProvider.of<CartModel>(
                      context,
                      listen: false,  // 打破ElevatedButton和InheritedWidget的依赖关系
                    );
                    cart!.add(Item(20.0, 1));
                  },
                );
              })
            ],
          );
        }),
      ),
    );
  }
}

// ChangeNotifier是一个通用的变化通知类，它实现了Listenable接口，可以说是一个发布者。
class CartModel extends ChangeNotifier {
  // 用于保存购物车中商品列表
  final List<Item> _items = [];

  // 禁止改变购物车里的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // 购物车中商品的总价,fold就是接受一个初始值和一个累积函数
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  // 将 [item] 添加到购物车。这是唯一一种能从外部改变购物车的方法。
  void add(Item item) {
    _items.add(item);
    // 通知监听器（订阅者），重新构建InheritedProvider， 更新状态。
    notifyListeners();
  }
}

class Item {
  Item(this.price, this.count);

  double price; //商品单价
  int count; // 商品份数
}
