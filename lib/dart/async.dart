import 'dart:async';

///Future与JavaScript中的Promise非常相似，表示一个异步操作的最终完成（或失败）及其结果值的表示。简单来说，它就是用于
///处理异步操作的，异步处理成功了就执行成功的操作，异步处理失败了就捕获错误或者停止后续操作。一个Future只会对应一个结果，
///要么成功，要么失败。还有，请记住，Future 的所有API的返回值仍然是一个Future对象，所以可以很方便的进行链式调用。

///dart是单线程模型,需要使用异步来处理耗时操作
///Main队列，事件队列，微队列。
///事件队列：先执行Future入队列，要知道这个队列的意思；微队列优先于事件队列
///await是等待Future执行完成，await后面的代码会放到事件队列里面,等待Main执行完成后,才会执行事件队列里面的代码

/// Dart中的async/await 和JavaScript中的async/await功能是一样的：异步任务串行化。

//Dart中使用`Future`和`await`的设计是为了处理异步操作。异步操作是指需要等待一段时间或者依赖外部资源才能得到结果的操作，
// 例如从网络请求数据、读取文件、执行耗时的计算等。在进行异步操作时，我们不希望整个程序阻塞在当前操作上，而是希望能够继续
// 执行其他任务，等待异步操作完成后再处理结果。
// `Future`是Dart中表示异步操作结果的一种机制。它表示一个将来可能会获得的值或错误。通过`Future`，我们可以在异步操作完
// 成时获取到它的结果，或者处理异步操作中发生的错误。
// `await`关键字用于等待`Future`的完成，并返回`Future`的值。当我们在使用`await`等待一个`Future`时，`await`会暂停
// 当前的执行流程，但不会阻塞整个程序。在等待期间，Dart虚拟机可以继续处理其他任务，提高了程序的并发性能。一旦`Future`完成，
// `await`将会返回`Future`的值，并恢复执行流程。
// 原理上，通过`await`等待一个`Future`时，Dart会将当前的执行上下文保存起来，并将`Future`对象添加到事件队列中等待其完成。。然后，Dart
// 会继续执行其他事件循环中的任务，直到遇到下一个事件循环的空闲时间。在这个过程中，Dart会不断检查`Future`
// 是否已经完成。一旦`Future`完成，Dart会将保存的执行上下文恢复，并将`Future`的值作为`await`的返回值。这样，我们就能够
// 获取到`Future`的实际结果并进行后续处理。
//
// 通过使用`Future`和`await`，我们可以更方便地处理异步操作，使代码更加简洁和易读。同时，Dart的异步机制也提供了更好的并发性能，
// 允许程序在等待异步操作时继续执行其他任务。
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
  // different();

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
  // task().then((_) => print('task then'));
  // print("task之后打印");
}

// 如果是闭包的写法,就会先执行
void different() {
  // 10 11 12 22
  new Future(() => print('s10'))
      .then((_) => new Future(() => print('s11')))
      .then((_) => print('s12'))
      .then((_) => print('s22'));

  // 10 12 22 11
  // new Future(() => print('s10'))
  //     .then((_) {
  //       new Future(() => print('s11'));
  //     })
  //     .then((_) => print('s12'))
  //     .then((_) => print('s22'));
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

// 在future中,回调函数 `() => print("f1")` 被传递给了`Future`的构造函数，意味着当这个`Future`对象完成时，这个回调函数会被调用。
// 7,1,6,3,5,2,4
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

  // 看different方法
  new Future(() => print('s10'))
      .then((_) => new Future(() => print('s11')))
      .then((_) => print('s12'));

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
    await saveUserInfo(
        userInfo); // 在异步函数中，如果没有使用`return`语句，函数内部的最后一个表达式的值将会被隐式地包装在一个`Future`中作为函数的返回值。
    //执行接下来的操作
  } catch (e) {
    //错误处理
    print(e);
  }
}

// 在Dart中，如果一个函数使用了`async`关键字进行标记，那么它可以返回一个`Future`对象，即使其
// 实际上返回的是一个具体的值。这是因为使用`async`标记的函数会被隐式地转换为返回一个`Future`。
// `login`函数被标记为`async`，并且它实际上返回了一个字符串："blend"。然而，由于它是一个异步函数，
// 因此它的返回类型是`Future<String>`，表示它将来会产生一个字符串值。
// 这种设计的好处是，它使得处理异步操作更加方便。在调用异步函数时，可以直接使用`await`关键字等
// 待其返回的结果，而不需要手动处理`Future`对象的完成和处理回调。
// 因此，尽管`login`函数返回的是一个具体的字符串值，但其返回类型是`Future<String>`，因为它
// 是一个异步函数。
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
