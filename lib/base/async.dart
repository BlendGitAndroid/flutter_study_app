import 'dart:async';

///Main队列，事件队列，微队列。
///事件队列：先执行Future入队列，要知道这个队列的意思；微队列优先于事件队列
// async wait
main() async {
  // getName1();
  // getName2();
  // getName3();
  //
  // //主要就是这三个方法的链式调用： then catchError whenComplete
  // onErrorAndCatch();
  //
  // //Future 7,1,6,3,5,2,4
  // testFuture();

  //scheduleMicroTask 918346572
  testScheduleMicroTask();
}

void onErrorAndCatch() {
  new Future(() => futureTask()) //  异步任务的函数
      .then((m) => "futureTask result:$m") //   任务执行完后的子任务
      .then((m) => print('then: $m')) //  其中m为上个任务执行完后的返回的结果
      .then((_) => new Future.error('error'))
      .then((m) => print('Blend'))
      .whenComplete(() => print('whenComplete1')) //不是最后执行whenComplete，通常放到最后回调

      //      .catchError((e) => print(e))//如果不写test默认实现一个返回true的test方法
      .catchError((e) => print('catchError:' + e), test: (Object o) {
        //可选参数
        print('test: $o');
        return true; //返回true，会被catchError捕获
        //        return false; //返回false，继续抛出错误，会被下一个catchError捕获
      })
      .catchError((e) => print('catchError2:' + e))
      .then((m) => print('Android'))
      .whenComplete(() => print('finish'));
}

//then catchError whenComplete
int futureTask() {
//  throw 'error';
  return 0;
}

void printLength(int length) {
  print("Text Length:$length");
}

//返回的是Future类型的
Future<void> getName1() async {
  getStr0(); //可以不用await打断点看下await后的区别
  await getStr1(); //遇到第一个await表达式执行暂停，返回future对象，await表达式执行完成后继续执行
  await getStr2(); //await表达式可以使用多次
  print('getName1');
  print('---------------------------------------------------------');
}

getStr0() {
  print('getStr0');
}

getStr1() {
  print('getStr1');
}

getStr2() {
  print('getStr2');
}

getName2() {
  print('getName2');
}

getName3() {
  print('getName3');
}

//Future
void testFuture() {
  //Future创建的会放到微队列里面
  Future f = new Future(() => print("f1"));
  Future f1 = new Future(() => null); //7163524
//  Future f1 = new Future.delayed(Duration(seconds: 1) ,() => null);//7132465
  Future f2 = new Future(() => null);
  Future f3 = new Future(() => null);

  f3.then((_) => print("f2"));
  f2.then((_) {
    print("f3");
    new Future(() => print("f4"));
    //为什么这里先打印f5，因为f1已经执行完了，当在f2里面再执行f1的时候，发现f1已经执行完了，就会把
    //f5放在微队列里面，当f2执行完毕后，发现微队列里面有数据，优先级最高，就会先执行微队列的数据
    f1.then((_) {
      print("f5");
    });
  });

  f1.then((m) {
    print("f6");
  });
  print("f7");
}

// 918346572
void testScheduleMicroTask() {
  scheduleMicrotask(() => print('s1')); //调用微任务

  new Future.delayed(new Duration(seconds: 1), () => print('s2'));

  new Future(() => print('s3')).then((_) {
    print('s4');
    scheduleMicrotask(() => print('s5'));
  }).then((_) => print('s6'));

  new Future(() => print('s10'))
      .then((_) => new Future(() => print('s11')))
      .then((_) => print('s12')); //这个是s11的then

  new Future(() => print('s7'));

  scheduleMicrotask(() => print('s8'));

  print('s9');
}
