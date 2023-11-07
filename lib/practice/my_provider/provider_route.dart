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
              Builder(builder: (context) {
                print("ElevatedButton build");
                return ElevatedButton(
                  child: const Text("添加商品"),
                  onPressed: () {
                    var cart = ChangeNotifierProvider.of<CartModel>(
                      context,
                      listen: false,
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
