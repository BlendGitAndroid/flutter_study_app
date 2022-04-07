///Dart变量
///Dart语言常用数据类型，int、double、num、String、dynamic、Object
///变量的默认值都是null，包括boolean类型

main(List<String> args) {
  ///变量定义
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
  double saleryPrice = 12.3;
  num weight = 1200;
  print(
      'name = $userName and age = $age,price = $saleryPrice,and weight = $weight');

  ///任意类型变量声明
  dynamic anything = 12;
  anything = 'good job';
  Object anythingObj = 'this is object type';
  anythingObj = 12;
  print('dynamic type $anything and anythingObj = $anythingObj');

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

  const PI = 3.1415926; // const 必须是明确的值，编译时确定值， 传递
  print(PI);

  final ls = [1, 2, 3, 4, 5, 6]; // 不传递不可变性，不影响子元素的可变性
  ls[1] = 10;
  print(ls);

  const ls1 = [1, 2, 3, 4, 5, 6]; // 传递不可变行，影响子元素的可变性
  // ls1[1] = 10; // 报错

  /// 使用const 定义的变量，如果在内存中已经存在， 则会复用
  const ls2 = [1, 2, 3, 4, 5, 6];
  print(identical(ls1, ls2)); // true ls1 和 ls2 是相同对象
}
