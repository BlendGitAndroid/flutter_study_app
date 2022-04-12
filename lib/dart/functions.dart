///函数
///返回类型可以省略
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

  //可选命名参数：使用 {param1, param2, …} 的形式来指定命名参数
  int add3({int x = 1, int y = 2, int z = 3}) {
    return x + y + z;
  }

  print(add3(y: 4));

  //可选位置参数：把可选参数放到 [] 中，必填参数要放在可选参数前面
  int add4(int x, [int y = 2, int z = 3]) {
    return x + y + z;
  }

  print(add4(1));

  //可选命名参数默认值(默认值必须是编译时常量),目前可以使用等号'='或冒号':'
  //Dart SDK 1.21 之前只能用冒号，冒号的支持以后会移除，所以建议使用等号
  int add5(int x, {int y = 2, int z = 3}) {
    return x + y + z;
  }

  //前面的必填参数没有名字
  print(add5(1, y: 10, z: 2));

  //可选位置参数默认值(默认值必须是编译时常量),只能使用等号'='
  int add6(int x, [int y = 2, int z = 3]) {
    return x + y + z;
  }

  print(add6(1));

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
  anonFunc1();

  //有参匿名函数
  var anonFunc = (name) => 'I am $name';
  print(anonFunc('android'));

  //通过()调用，不推荐
//  (()=>print('不推荐'))();

  //匿名函数传参
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

  //返回Function对象（闭包）
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

//函数别名，函数签名要一致
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
