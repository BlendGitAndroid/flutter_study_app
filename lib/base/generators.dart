import 'dart:async';

//同步和异步生成器
main() {
  //同步生成器
  generator1();

  //异步生成器
  generator2();

  //递归生成器
  //同步
  var it1 = getSyncRecursiveGenerator(5).iterator;
  while (it1.moveNext()) {
    print(it1.current);
  }
  //异步
//  getAsyncRecursiveGenerator(5).listen((value) => print(value));
  print('over');
}

void generator2() {
  //调用getAsyncGenerator立即返回Stream,只有执行了listen，函数才会开始执行
  getAsyncGenerator(5).listen((value) => print(value));
  StreamSubscription subscription = getAsyncGenerator(5).listen(null);
  subscription.onData((value) {
    print(value);
    if (value >= 2) {
      subscription.pause(); //可以使用StreamSubscription对象对数据流进行控制
    }
  });
}

void generator1() {
  //调用getSyncGenerator立即返回Iterable
  var it = getSyncGenerator(5).iterator;
  //  调用moveNext方法时getSyncGenerator才开始执行
  while (it.moveNext()) {
    print(it.current);
  }
}

//同步生成器： 使用sync*，返回的是Iterable对象
Iterable<int> getSyncGenerator(int n) sync* {
  print('start');
  int k = n;
  while (k > 0) {
    //yield会返回moveNext为true,并等待 moveNext 指令
    yield k--;
  }
  print('end');
}

//异步生成器： 使用async*，返回的是Stream对象
Stream<int> getAsyncGenerator(int n) async* {
  print('start');
  int k = 0;
  while (k < n) {
    //yield不用暂停，数据以流的方式一次性推送,通过StreamSubscription进行控制
    yield k++;
  }
  print('end');
}

//递归生成器：使用yield*
Iterable<int> getSyncRecursiveGenerator(int n) sync* {
  if (n > 0) {
    yield n;
    yield* getSyncRecursiveGenerator(n - 1);
  }
}

//异步递归生成器
Stream<int> getAsyncRecursiveGenerator(int n) async* {
  if (n > 0) {
    yield n;
    yield* getAsyncRecursiveGenerator(n - 1);
  }
}
