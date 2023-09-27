///类似于多继承
///extends -> mixins -> implements
/// 子类不但可以重写父类的方法, 也可以重写父类的变量
/// 当把一个类当做一个隐式的接口进行实现时，需要重写它所有的方法和成员变量
/// 1. extends继承规定了一个类时什么；
/// 2. implements实现接口表明了一个类有什么功能；
/// 3. with混入则是为类增加了某些功能，最重要的功能是复用代码。它与implements的显著区别是无需重写实现混入类的所有方法(抽象方法除外)
main() {
  Bicycle().transport();
  Motorcycle().transport();
  Car().transport();
  //四轮木制脚踏车
  WoodenCar().transport();

  print(AB().getMessage());
  print(BA().getMessage());
  print(C().getMessage());
  print(CC().getMessage());

  print('*' * 10);

  print(A().getMessage());
}

//交通工具类，拥有运输功能
abstract class Transportation {
  //运输功能
  void transport();
}

//自行车
class Bicycle extends Transportation
    with TwoWheelTransportation, LowSafetyIndex, BodyEnergyTransportation {
  @override
  void transport() {
    print(
        "自行车:\n动力组件: ${powerUnit()} , 安全指数： ${safetyIndex()} , 动力来源：${energy()}");
  }
}

//摩托车
class Motorcycle extends Transportation
    with TwoWheelTransportation, LowSafetyIndex, GasolineEnergyTransportation {
  @override
  void transport() {
    print(
        "摩托车:\n动力组件: ${powerUnit()} , 安全指数： ${safetyIndex()} , 动力来源：${energy()}");
  }
}

//汽车
class Car extends Transportation
    with
        FourWheelTransportation,
        MiddleSafetyIndex,
        GasolineEnergyTransportation {
  @override
  void transport() {
    print(
        "汽车:\n动力组件: ${powerUnit()} , 安全指数： ${safetyIndex()} , 动力来源：${energy()}");
  }
}

//双轮交通工具
class TwoWheelTransportation {
  String powerUnit() => "两个轮子";
}

//四轮交通工具，一般来说安全性能为中
class FourWheelTransportation {
  String powerUnit() => "四个轮子";
}

//安全指数中等的交通工具儿
class MiddleSafetyIndex {
  String safetyIndex() => "middle";
}

//安全指数低的交通工具儿
class LowSafetyIndex {
  String safetyIndex() => "low";
}

//人力发动机
class BodyEnergyTransportation {
  String energy() => "全靠腿登";
}

//汽油能源交通工具
class GasolineEnergyTransportation {
  String energy() => "汽油";
}

//四轮木制脚踏车
// 在这个列子中,extends和implements的区别
// 如果当前使用类重写了该方法，就会调用当前类中的方法。
// 如果当前使用类没有重写了该方法，则会调用距离with关键字最远类中的方法。
// implements就是实现的意思, 也就是说, 当一个类实现了一个接口时, 它必须实现接口中的所有方法和
// 成员变量,那这个接口只要实现就行了,下面的这个例子中就是Car实现了LowSafetyIndex, BodyEnergyTransportation的意思
// 而with是混入,会调用距离with关键字最远类中的方法
class WoodenCar extends Car //with LowSafetyIndex, BodyEnergyTransportation
//implements LowSafetyIndex, BodyEnergyTransportation
{
  @override
  void transport() {
    print(
        "四轮木制脚踏车:\n动力组件: ${powerUnit()} ， 安全指数： ${safetyIndex()} ， 动力来源：${energy()}");
  }
}

//顺序问题
//如果2个或多个超类拥有相同签名的A方法，那么子类会以继承的最后一个超类中的A方法为准。
//当然这是子类没有重写A方法的前提下，如果子类自己重写了A方法则以本身的A方法为准
class A {
  String getMessage() => 'A';
}

class B {
  String getMessage() => 'B';
}

class P {
  String getMessage() => 'P';
}

class AB extends P with A, B {}

class BA extends P with B, A {}

//优先级最高的是在具体类中的方法。
class C extends P with B, A {
  String getMessage() => 'C';
}

//这里的implement只是表明要实现A的方法，这个时候具体实现是在B中mixin了具体实现
class CC extends P with B implements A {}

class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void sayHello() {
    print("Hello, I'm $name, $age years old.");
  }

  void sayBye() {
    print("Bye, I'm $name, $age years old.");
  }
}

// implements必须实现所有的方法和成员变量
class XiaoMing implements Person {
  @override
  int age;

  @override
  String name;

  XiaoMing(this.name, this.age);

  @override
  void sayBye() {}

  @override
  void sayHello() {}
}

// extends不需要实现所有的方法和成员变量
class XiaoHong extends Person {
  XiaoHong(String name, int age) : super(name, age);

  @override
  void sayBye() {
    super.sayBye();
  }
}

// 这个原因是因为类'Person'声明了一个构造函数，所以它不能被用作一个mixin。
// 在Dart中，mixin是一种特殊的类，它可以在其他类中重用一些功能。当一个类被用作mixin时，
// 它不能有自己的构造函数，因为mixin不是用来创建类的实例的。
// 而在这种情况下，'Person'类声明了一个构造函数，这意味着它被设计用来创建类的实例。因此，它不能
// 被用作一个mixin，因为mixin只是用来重用功能而不是创建实例的。所以，由于'Person'类有构造函数，
// 它不能被用作一个mixin。
// 也就是Person类不能被用作mixin，因为它有构造函数，而mixin不能被用来创建类的实例。
// class XiaoZhang with Person {
//
// }
