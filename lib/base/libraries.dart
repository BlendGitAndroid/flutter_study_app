//一个库可以使用的全部对象包括这个库本身声明的，以及通过导入语句从其他库导入的。
// 在dart：core中定义的对象是隐式导入的。而一个库对外可使用的对象称为库导出的命名空间。
import 'dart:math'; //载入核心库

//使用 package：导入方式会执行一个常驻的封装了代码位置信息的包管理器。
import 'package:dio/dio.dart'; //载入第三库

import 'customLib/custom_lib.dart'; //载入自定义库，进行了库的拆分
// import 'library2.dart' as lib2 hide Test; //筛选掉库的某些部分
// import 'library1.dart' as lib1 show Test; //只载入库的某些部分

import 'library1.dart' deferred as lazyLib; //延迟载入

///库的拆分：有的时候一个库可能太大，不能方便的保存在一个文件当中。Dart允许我们把一个库拆分成一个或者多个较小的part组件。
///Part与import有什么区别
///可见性：如果说在A库中import了B库，A库对B库是不可见的，也就是说B库是无法知道A库的存在的。
///而part的作用是将一个库拆分成较小的组件。两个或多个part共同构成了一个库，它们彼此之间是知道互相的存在的。
///作用域：import不会完全共享作用域，而part之间是完全共享的。如果说在A库中import了B库，
///B库import了C库，A库是没有办法直接使用C库的对象的。而B,C若是A的part，那么三者共享所有对象，并且包含所有导入。

main() {
  //使用核心库
  print(sqrt(4));

  //使用第三方库
  getHttp();

  //载入文件
  // var myLib1 = lib1.Library1();
  // var myLib2 = lib2.Library2();

  //选择性载入文件
  // var test = lib1.Test();
  // var lib = lib2.Library2();

  //延迟载入
  lazyLoad();

  //载入自定义库
  printCustomLib();
  printUtil();
  printTool();
}

//调用第三方库
void getHttp() async {
  try {
    Response response = await Dio().get("https://www.baidu.com");
    print(response);
  } catch (e) {
    print(e);
  }
}

//延迟载入
//可提高程序启动速度
//用在不常使用的功能
//用在载入时间过长的包
lazyLoad() async {
  await lazyLib.loadLibrary();
  var t = lazyLib.Test();
  t.test();
}
