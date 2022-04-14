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

  @override
  noSuchMethod(Invocation mirror) {
    print('没有找到方法');
  }

  @MetadataCustom(who: 'Blend', what: 'create a new method')
  void doSomething() {
    print('doSomething');
  }
}
