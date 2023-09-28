///函数
///返回类型可以省略
///Dart是一种真正的面向对象的语言，所以即使是函数也是对象，并且有一个类型Function。
///这意味着函数可以赋值给变量或作为参数传递给其他函数，这是函数式编程的典型特征。
main() {
  //普通函数定义
  int add(int x, int y) {
    return x + y;
  }

  print(add(1, 2));

  //所有的函数都返回一个值。如果没有指定返回值，则默认把语句return null; 作为函数的最后一个语句执行。
  testFunc() {}
  print(testFunc()); //返回null，一切皆对象

  //可省略类型(不建议)
  add1(x, y) {
    return x + y;
  }

  print(add1('1', '2'));
  print(add1(1, 2));

  //箭头函数：=>表达式，只有一行，胖箭头
  int add2(int x, int y) => x + y;

  print(add2(1, 2));

  //可选命名参数，用{}来表示：使用 {param1, param2, …} 的形式来指定命名参数
  int add3({int x = 1, int y = 2, int z = 3}) {
    return x + y + z;
  }

  // 要记住,函数形参里面的,就是命名参数{}
  int add33({int? x, int? y}) {
    return 0;
  }

  print(add3(y: 4));

  //可选位置参数，用[]来表示：把可选参数放到 [] 中，必填参数要放在可选参数前面
  int add4(int x, [int y = 2, int z = 3]) {
    return x + y + z;
  }

  print(add4(1));

  //可选命名参数默认值(默认值必须是编译时常量)
  int add5(int x, {int y = 2, int z = 3}) {
    return x + y + z;
  }

  // 如果最后一个参数没有默认值，那么就要使用可空运算符(?)
  int add55(int x, {int y = 2, int? z}) {
    return x + y;
  }

  //前面的必填参数没有名字
  print(add5(1, y: 10, z: 2));

  //可选位置参数默认值(默认值必须是编译时常量),只能使用等号'='
  int add6(int x, [int y = 2, int z = 3]) {
    return x + y + z;
  }

  // 如果最后一个参数没有默认值，那么就要使用可空运算符(?)
  int add66(int x, [int y = 2, int? z]) {
    return x + y;
  }

  print(add6(1, 4, 5));

  //区别：
  // - 可选位置参数是按照参数的位置进行匹配，而可选命名参数是通过指定参数名进行匹配。
  // - 可选位置参数使用方括号([])括起来，可选命名参数使用花括号({})括起来。
  // - 在函数调用时，可选位置参数可以按照位置传递参数，也可以省略某个参数；可选命名参数可以通过指定参数名来传递参数，也可以省略某个参数。

  //使用list或map作为默认值，但必须是const，防止改动
  void func(
      {List list = const [1, 2, 3],
      Map map = const {1: 1, 'name': 'android'}}) {
    // list[0] = 4;   Cannot modify an unmodifiable list
    // list.add(4); 一样的不能更改
    print("map and list : $list");
  }

  func();

  //匿名函数
  //赋值给变量
  //无参匿名函数
  var anonFunc1 = () => print('无参匿名函数');
  var anonFunc11 = () { print('无参匿名函数11');};
  anonFunc1();

  //有参匿名函数
  var anonFunc = (name) => 'I am $name';
  print(anonFunc('android'));

  //通过()调用，不推荐
//  (()=>print('不推荐'))();

  //匿名函数传参
  // 第一个参数是一个List，第二个参数是一个函数，函数的参数是一个String，返回值也是一个String
  List test(List<String> list, String func(str)) {
    for (var i = 0; i < list.length; i++) {
      list[i] = func(list[i]);
    }
    return list;
  }

  var list = ['b', 'l', 'e', 'n', 'd'];
  print(test(list, (str) => str * 2)); //String * int, Dart和Python可以这样用

  //List.forEach()就用的匿名函数
  List list1 = [11, 12, 13];
  list1.forEach((item) => print('$item'));
  // 下面的就是上面 => 的完整写法,上面的是匿名函数
  list1.forEach((item) {
    forEachTest(item);
  });

  // 返回Function对象（闭包）
  // 返回一个function对象,入参是int，返回值是int
  Function makeAddFunc(int x) {
    x++;
    return (int y) => x + y;
  }

  var addFunc = makeAddFunc(2);
  print(addFunc(3));

  // 函数别名
  MyFunc myFunc;
  //可以指向任何同签名的函数
  myFunc = subtraction;
  myFunc(4, 2);
  myFunc = divide;
  myFunc(4, 2);
  //typedef 作为参数传递给函数
  calculator(4, 2, subtraction);
}

void forEachTest(int a) {
  print("forEachTest $a");
}

//typedef定义函数别名，函数签名要一致
typedef MyFunc(int a, int b);

//根据MyFunc相同的函数签名定义两个函数
subtraction(int a, int b) {
  print('subtraction: ${a - b}');
}

divide(int a, int b) {
  print('divide: ${a / b}');
}

//typedef 也可以作为参数传递给函数
calculator(int a, int b, MyFunc func) {
  func(a, b);
}
