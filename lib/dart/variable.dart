///Dart变量，三斜杠文档注释

/// 没有初始化的变量自动获取一个默认值为
///var:如果没有初始值，可以变成任何类型
///dynamic:动态任意类型，编译阶段不检查类型
///Object:动态任意类型，编译阶段检查检查类型
///区别：
///唯一区别 var 如果有初始值，类型被锁定

///变量的默认值都是null，包括boolean类型，一切都是对象

///final和const
///1.被final或者const修饰的变量，变量类型可以省略
///2.被 final 或 const 修饰的变量无法再去修改其值。并且const具体传递性，他的子元素也不可变
///3.final或const不能和var同时使用。

main(List<String> args) {
  ///变量定义，进行类型推断为String，之后不能进行更改
  var str1 = 'are you ok ?';
  print(str1);

  ///使用var声明的变量，初始化后，变量的类型就已经确定，后续再赋值，只能是初始化的数据类型
  ///str1 = 12;  //A value of type 'int' can't be assigned to a variable of type 'String'.

  ///只声明变量，不初始化
  ///使用var声明变量，但不赋值初始化数据，则变量为dynamic类型，即变量类型可以是任何数据类型
  var anyType;
  anyType = 'this is a enery type.';
  print(anyType);
  anyType = 12;
  print('every type = $anyType');
  anyType = true;
  print('every type = $anyType');

  ///使用强类型定义变量，类型确定之后，变量类型就不可变了
  String userName = 'Blend';
  int age = 20;
  double salaryPrice = 12.3;
  num weight = 1200;
  print(
      'name = $userName and age = $age,price = $salaryPrice,and weight = $weight');

  ///任意类型变量声明，注意dynamic和Object的区别
  dynamic anything = 12;
  anything = 'good job';
  // anything.test(); //编译时不会检查类型，这就是和Object的区别

  // 这样也是可以的，就是和dynamic一样
  Object anythingObj = 'this is object type';
  anythingObj = 12;
  print('dynamic type $anything and anythingObj = $anythingObj');
  // anythingObj.test();    编译不过，会检查类型

  ///字符变量
  String strDefine1 =
      'this is ' 'a body'; // String 两个字符串之间有空格，在dart中也会将两个字符串连接起来
  print(strDefine1);
  var strDefine2 = '这样'
      '其实'
      '也可以';
  print(strDefine2);

  //原样转义输出
  String strDefine3 = """ i want the computer
  this is a good
  """;
  print('原样输出 \n$strDefine3');

  //原样不转义输出
  String strDefine4 =
      r"love is a short ,\n forgetting is so long"; //在字符串前面加上r，则表示字符串中的转移字符，不进行转义，原样输出
  print("转义字符原样输出 = \n$strDefine4");
  print(strDefine4.length);

  /// 遍历输出字符串
  // for (int i = 0; i < strDefine3.length; i++) {
  //   print(strDefine3[i]);
  // }

  /// 常量，final const,一旦赋值则不可修改  特性：不可变性可传递
  final DateTime currentDateTime = DateTime.now(); // 赋值之后就不可修改，运行时确定值，不传递
  print(currentDateTime);

  // const是一个编译时的常量
  const PI = 3.1415926; // const 必须是明确的值，编译时确定值， 传递
  print(PI);

  final ls = [1, 2, 3, 4, 5, 6]; // 不传递不可变性，不影响子元素的可变性
  // final ls = const [1, 2, 3, 4, 5, 6];   注意区分数组前面加const和不加const的情况，加了const的不能改变他的值
  ls[1] = 10;
  print(ls);

  const ls1 = [1, 2, 3, 4, 5, 6]; // 传递不可变行，影响子元素的可变性
  // ls1[1] = 10; // 报错

  /// 使用const 定义的变量，如果在内存中已经存在， 则会复用
  const ls2 = [1, 2, 3, 4, 5, 6];
  // `identical` 方法比较的是对象的引用，而不是对象的值
  print(identical(ls1, ls2)); // true ls1 和 ls2 是相同对象

  /// ---------------------------------final和const--------------------------------
  //1.  被final或者const修饰的变量，变量类型可以省略
  final fVariable1 = 'blend';
//  final String fVariable1 = 'blend';
  const cVariable1 = 'blend';
//  const String cVariable1 = 'blend';

  //2.  被 final 或 const 修饰的变量无法再去修改其值。
//   fVariable1 = 'android';
//   cVariable1 = 'android';

  //3.  final或const不能和var同时使用。
//  final var fVariable1 = 'blend';
//  const var fVariable1 = 'blend';

  //4.  如果是类级别常量，使用static const
  DateTime; //可参照DateTime static const int monday = 1;

  //5.  const可以使用其他 const常量的值来初始化其值
  const width = 100;
  const height = 100;
  const square = width * height;

  //6.  const赋值 申明可省略
  const List clist = [1, 2, 3];
//  const List clist = const [1, 2, 3];//dart 2之前，const赋值必须用const声明

  //7.  可以更改非final,非const变量的值，即使它曾经具有const值
  var varList = const [1, 2, 3];
  final finalList = const [1, 2, 3];
  const constList = [1, 2, 3];
  varList = [1];
//  constList = [1];
//  finalList = [1];

  //8.  const导致的不可变性是可传递的
  final List nls = [1, 2, 3];
  nls[1] = 4;
  print(nls);
  const List nls1 = [1, 2, 3];
//  nls1[1] = 4;

  //9. 相同的const常量不会在内存中重复创建
  final finalList1 = [1, 2];
  final finalList2 = [1, 2];
  print(identical(finalList1, finalList2)); //identical用于检查两个引用是否指向同一个对象

  const constList1 = [1, 2];
  const constList2 = [1, 2];
  print(identical(constList1, constList2)); //identical用于检查两个引用是否指向同一个对象

  //10. const 需要是编译时常量
  final DateTime finalDateTime = DateTime.now();
  //  const DateTime constDateTime = DateTime.now();//DateTime.now() 是运行期计算出来的值
  const sum = 1 + 2; //使用内置数据类型的字面量通过基本运算得到的值
  const aConstNum = 0;
  const aConstBool = true;
  const aConstString = 'a constant string';
  const aConstNull = null;
  const validConstString =
      '$aConstNum, $aConstBool, $aConstString, $aConstNull';
  print(validConstString); //使用计算结果为null或数字，字符串或布尔值的编译时常量的插值表达式

  // 空安全
  // - `?.`：可选调用运算符。用于访问可能为null的属性或方法。
  // - `??`：空合并运算符。用于提供一个默认值，当变量为null时使用。
  // - `!`：非空断言运算符。用于断言一个变量不为null。
  int i = 8; //默认为不可空，必须在定义时初始化。
  int? j; // 定义为可空类型，对于可空变量，我们在使用前必须判空。
  print(j?.toString()); // 使用?.操作符，如果j为空，则返回null，否则返回j.toString()的值

// 如果我们预期变量不能为空，但在定义时不能确定其初始值，则可以加上late关键字，
// 表示会稍后初始化，但是在正式使用它之前必须得保证初始化过了，否则会报错
  late int k;
  k = 9;

  print(int); //这里会打印出int
}
