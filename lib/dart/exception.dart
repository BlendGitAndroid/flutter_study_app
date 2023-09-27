///分为ERROR和Exception
main() {
  /// ---------------------------------异常的抛出throw--------------------------------
  //抛出Exception对象
//  throw new FormatException('格式异常');

  //抛出Error对象
//  throw new OutOfMemoryError();

  //抛出任意非null对象
//  throw '这是一个异常';

//除了`try-catch`，Dart还提供了其他处理异常的关键字和语法：
// - `finally`：无论是否引发异常，`finally`块中的代码总是会执行。
// - `on`：用于指定捕获特定类型异常的情况。
// - `rethrow`：用于重新抛出已捕获的异常。

  /// ---------------------------------异常的捕获try catch--------------------------------
  try {
    // throw new OutOfMemoryError();
    throw new FormatException();
  } on OutOfMemoryError {
    //on 指定异常类型
    print('没有内存了');
//    rethrow; //把捕获的异常给 重新抛出
  } on Error catch (e) {
    //捕获Error类型
    print("Error：${e.toString()}");
    print('Unknown error catch');
  } on Exception catch (e, s) {
    //捕获Exception类型
    print("Exception：${e.toString()}");
    print('Unknown exception catch');
    print(s);
  } catch (e, s) {
    //catch() 可以带有一个或者两个参数， 第一个参数为抛出的异常对象， 第二个为StackTrace对象堆栈信息
    print(e);
    print(s);
  } finally {
    //无论是否引发异常，`finally`块中的代码总是会执行。
    print('finally');
  }
}
