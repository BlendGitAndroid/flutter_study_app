import 'metadataCustom.dart';

//注解
main() {
  dynamic tv = new Television();
  tv.activate();
  tv.turnOn();
  tv.turnOff();
  tv.doSomething();
}

class Television {
  @deprecated
  void activate() {
    turnOn();
  }

  void turnOn() {
    print('Television turn on!');
  }

  // `noSuchMethod`是一个特殊的方法，用于处理在对象上调用不存在的方法的情况。当对象
  // 上调用一个不存在的方法时，Dart会自动调用`noSuchMethod`方法，并传递一个`Invocation`对象作为参数。
  @override
  noSuchMethod(Invocation mirror) {
    print('没有找到方法');
  }

  // 自定义注解,也是定义一个类
  @MetadataCustom(who: 'Blend', what: 'create a new method')
  void doSomething() {
    print('doSomething');
  }
}
