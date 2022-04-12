import 'dart:math';

main() {
  //普通构造函数
  var p = Point(1, 1); //new 可省略 var point = Point(1, 2);
  print(p);
//  Point p1;
//  print(p1.runtimeType); //可以使用Object类的runtimeType属性,获取对象的类型

  //命名构造函数
  p = Point.fromJson({'x': 2, 'y': 2});
  print(p);

  //重定向构造函数
  p = Point.alongXAxis(0);
  print(p);

  //调用超类构造函数
  var child = Child.fromJson(1, 2);
  var child1 = Child(3, 4);

  //常量构造函数
  var p2 = const Point2(4, 4);
  print(p2);
  var p21 = Point2(4, 4); //创建的是非 常量对象
  var p22 = const Point2(4, 4);
  print(identical(p2, p21));
  print(identical(p2, p22));

  //工厂方法构造函数
  var singleton1 = Singleton('blend');
  var singleton2 = Singleton('android');
  print(identical(singleton1, singleton2));

  //工厂模式两种方式
  //创建顶级函数
  var rnAndroid = AndroidFactory('rn');
  rnAndroid.doAndroid();

  //创建工厂构造函数
//  var rnAndroid = new Android('rn');
//  rnAndroid.doAndroid();
//  var FlutterAndroid = new Android('flutter');
//  FlutterAndroid.doAndroid();
//  var specialAndroid = new Android('%#@##@##');
//  specialAndroid.doAndroid();

  //set get
  var rect = new Rectangle(1, 1, 10, 10);
  print(rect.left);
  rect.right = 12;
  print(rect.left);

  //implement 一个普通类
  var programmer = Programmer();
  programmer.work();

  //可调用类
  var cf = new ClassFunction();
  var out = cf("blend", "flutter,", "android");
  print('$out'); // blend flutter, android!
  print(cf.runtimeType); // ClassFunction
  print(out.runtimeType); // String
  print(cf is Function); // false
  print(out is Function); // false

  //重载操作符
  final v1 = Vector(2, 3);
  final v2 = Vector(2, 2);
  final r1 = v1 + v2;
  final r2 = v1 - v2;
  print([r1.x, r1.y]);
  print([r2.x, r2.y]);
}

class Point {
  num x = 0;
  num y = 0;
  var distanceFromOrigin;

  //普通构造函数，这是Java的写法
//  Point(num x, num y){
//    this.x = x;
//    this.y = y;
//  }

  //默认构造函数，这是Dart的写法
  // Point(this.x, this.y);

  //命名构造函数
  Point.fromJson(Map json) {
    x = json['x'];
    y = json['y'];
  }

  //重定向构造函数 使用冒号调用其他构造函数
  Point.alongXAxis(num x) : this(x, 0);

  //初始化列表
  Point(this.x, this.y) : distanceFromOrigin = sqrt(x * x + y * y);

  @override
  String toString() {
    return 'Point(x = $x, y = $y)';
  }
}

class Parent {
  int x;
  int y;

  //超类命名构造函数不会传递，如果希望使用超类中定义的命名构造函数创建子类，则必须在子类中实现该构造函数
  Parent.fromJson(x, y)
      : x = x,
        y = y {
    print('超类命名构造函数');
  }
}

class Child extends Parent {
  int x = 0;
  int y = 0;

  //如果超类没有默认构造函数， 则你需要手动的调用超类的其他构造函数
  Child(x, y) : super.fromJson(x, y) {
    //调用超类构造函数的参数无法访问 this
    print('子类构造函数');
  }

  //在构造函数的初始化列表中使用 super()，需要把它放到最后
  Child.fromJson(x, y)
      : x = x,
        //所以这里是先赋值，再调用父类，将x的值赋值给this的x
        y = y,
        super.fromJson(x, y) {
    print('子类命名构造函数');
  }
}

//常量构造函数
class Point2 {
  //定义const构造函数要确保所有实例变量都是final
  final num x;
  final num y;
  static final Point2 origin = const Point2(0, 0);

  //const关键字放在构造函数名称之前,不能有函数体
  const Point2(this.x, this.y);

  @override
  String toString() {
    return 'Point2(x = $x, y = $y)';
  }
}

class Singleton {
  String name;
  static Singleton? _cache; //工厂构造函数无法访问 this。所以这里要静态的

  //工厂构造函数，关键字factory
  //工厂构造函数是一种构造函数,与普通构造函数不同,工厂函数不会自动生成实例,而是通过代码来决定返回的实例对象.
//  factory Singleton([String name = 'singleton']) {
////    if(Singleton._cache == null){
////      Singleton._cache=new Singleton._newObject(name);
////    }
////    return Singleton._cache;
//
//    return Singleton._cache ??= Singleton._newObject(name);
//  }
  factory Singleton([String name = 'singleton']) =>
      Singleton._cache ??= Singleton._newObject(name);

//定义一个命名构造函数用来生产实例
  Singleton._newObject(this.name);
}

//工厂函数
class Android {
  void doAndroid() {
    print('Android');
  }
}

class ReactNativeAndroid extends Android {
  @override
  doAndroid() {
    print('ReactNative');
  }
}

class FlutterAndroid extends Android {
  @override
  void doAndroid() {
    print('Flutter');
  }
}

class NativeAndroid extends Android {
  @override
  void doAndroid() {
    print('native');
  }
}

Android AndroidFactory(String type) {
  switch (type) {
    case 'rn':
      return new ReactNativeAndroid();
    case 'flutter':
      return new FlutterAndroid();
    default:
      return new NativeAndroid();
  }
}

//工厂模式
// abstract class Android {
//  factory Android(String type) {
//    switch (type) {
//      case 'rn':
//        return new ReactNativeAndroid();
//      case 'Flutter':
//        return new FlutterAndroid();
//      default:
//        return new NativeAndroid();
//    }
//  }
//
//  void doAndroid();
// }
//
// class ReactNativeAndroid implements Android {
//  @override
//  doAndroid() {
//    print('ReactNative');
//  }
// }
//
// class FlutterAndroid implements Android {
//  @override
//  void doAndroid() {
//    print('Flutter');
//  }
// }
//
// class NativeAndroid implements Android {
//  @override
//  void doAndroid() {
//    print('Flutter');
//  }
// }

//setter getter
//每个实例变量都隐含的具有一个 getter， 如果变量不是 final 的则还有一个 setter
//可以通过实行 getter 和 setter 来创建新的属性， 使用 get 和 set 关键字定义 getter 和 setter
class Rectangle {
  num left;
  num top;
  num width;
  num height;

  Rectangle(this.left, this.top, this.width, this.height);

  // getter 和 setter 的好处是，可以开始使用实例变量，后面可以把实例变量用函数包裹起来，而调用你代码的地方不需要修改。
  //获取right值
  num get right => left + width;

  //设置right值，同时left也发生变化
  set right(num value) => left = value - width;

  //获取bottom值
  num get bottom => top + height;

  //设置bottom值，同时top也发生变化
  set bottom(num value) => top = value - height;
}

//implement 一个普通类
class People {
  void work() {
    print('people work');
  }
}

class Programmer implements People {
  @override
  void work() {
    print('programmer work');
  }
}

//可调用类
class ClassFunction {
  call(String a, String b, String c) => '$a $b $c!';
}

//重载操作符
class Vector {
  final int x;
  final int y;

  const Vector(this.x, this.y);

  //重载+
  Vector operator +(Vector v) {
    return new Vector(x + v.x, y + v.y);
  }

  //重载-
  Vector operator -(Vector v) {
    return new Vector(x - v.x, y - v.y);
  }
}
