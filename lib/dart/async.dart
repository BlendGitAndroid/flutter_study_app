import 'dart:async';

///Future与JavaScript中的Promise非常相似，表示一个异步操作的最终完成（或失败）及其结果值的表示。简单来说，它就是用于
///处理异步操作的，异步处理成功了就执行成功的操作，异步处理失败了就捕获错误或者停止后续操作。一个Future只会对应一个结果，
///要么成功，要么失败。还有，请记住，Future 的所有API的返回值仍然是一个Future对象，所以可以很方便的进行链式调用。

///dart是单线程模型,需要使用异步来处理耗时操作
///Main队列，事件队列，微队列。
///事件队列：先执行Future入队列，要知道这个队列的意思；微队列优先于事件队列
///await是等待Future执行完成，await后面的代码会放到事件队列里面,等待Main执行完成后,才会执行事件队列里面的代码

/// Dart中的async/await 和JavaScript中的async/await功能是一样的：异步任务串行化。
void main() {
  // getName1().then((_) => print('getName1 then'));
  // getName2();
  // getName3();
  //
  // //主要就是这三个方法的链式调用： then catchError whenComplete
  // onErrorAndCatch();
  //
  // //Future 7,1,6,3,5,2,4
  // testFuture();
  //
  // //scheduleMicroTask 918346572
  // testScheduleMicroTask();
  //
  // // 需要等待多个异步任务都执行结束后才进行一些操作，答案是Future.wait，它接受一个Future数组
  // // 参数，只有数组中所有Future都执行成功后，才会触发then的成功回调，只要有一个Future执行失败，
  // // 就会触发错误回调。
  // Future.wait([
  //   // 2秒后返回结果
  //   Future.delayed(Duration(seconds: 2), () {
  //     return "hello";
  //   }),
  //   // 4秒后返回结果
  //   Future.delayed(Duration(seconds: 4), () {
  //     return " world";
  //   })
  // ]).then((results) {
  //   print(results[0] + results[1]);
  // }).catchError((e) {
  //   print(e);
  // });

  //-----------------------------------------------------------------------------

  // 先打印"task之后打印",这句话
  task().then((_) => print('task then'));
  print("task之后打印");
}

// then中接收异步结果并处理
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

// 返回的是Future类型的
// `await`关键字只能用于异步函数中，用于等待一个`Future`对象的完成并获取其结果。它不能直接用于普通的同步方法调用。
Future<void> getName1() async {
  getStr0(); //可以不用await打断点看下await后的区别
  await getStr1(); //异步函数中使用`await`关键字等待异步操作的完成，并返回异步操作的结果,将结果以Future返回
  await getStr2(); //await表达式可以使用多次
  print('getName1');
  print('---------------------------------------------------------');
}

getStr0() {
  print('getStr0');
}

// 使用async修饰的方法返回的是Future类型的,就是异步函数
Future<void> getStr1() async {
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
// 在future中,回调函数 `() => print("f1")` 被传递给了`Future`的构造函数，意味着当这个`Future`对象完成时，这个回调函数会被调用。
void testFuture() {
  Future f = new Future(() => print("f1"));
  Future f1 = new Future(() => null);
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

//------------------------------------------------------------------------------------------------

// 关键字async和await是Dart语言异步支持的一部分。
//
// async：用来表示函数是异步的，定义的函数会返回一个 Future 对象。
// await：后面跟着一个 Future，表示等待该异步任务完成后才会继续往下执行。await只能出现在异步函数内部，
// 能够让我们可以像写同步代码那样来执行异步任务而不使用回调的方式。
// await关键字使用必须满足两个条件：
// 当前函数必须是异步函数(即在函数头中包含关键字async的函数);
// await修饰的任务必须是异步任务

Future<void> task() async {
  try {
    String id = await login("alice", "******");
    String userInfo = await getUserInfo(id);
    await saveUserInfo(userInfo);
    //执行接下来的操作
  } catch (e) {
    //错误处理
    print(e);
  }
}

Future<String> login(String userName, String pwd) async {
  //用户登录
  return "blend";
}

Future<String> getUserInfo(String id) async {
  //获取用户信息
  return "getUserInfo: " + id;
}

Future<void> saveUserInfo(String userInfo) async {
  // 保存用户信息
  print(userInfo);
}
