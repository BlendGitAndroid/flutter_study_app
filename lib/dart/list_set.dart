///集合 list and set
main() {
  /// 定义list
  // List是一个抽象类，不能直接实例化，需要使用empty来创建一个空的list
  List<String> list = List<String>.empty();

  var ls = [1, 2, 3, 4, 5, 6]; // 推荐
  ls.remove(2); // 删除元素
  for (var item in ls) {
    print(item);
  }
  print('list siz = ${ls.length}');

  ls.forEach((item) {
    print(item);
  });

  print('*' * 100);

  /// 链式操作
  ls
    ..add(30)
    ..add(20)
    ..add(40);
  ls.forEach((item) => print(item));  //函数的简写

  /// 元素不可重复列表
  print('--' * 50);
  Set<String> set1 = {'1', '2', '3', '3', '2'};
  print(set1); // 会去除重复元素
  set1.forEach((item) => print(item));

  print('-' * 80);
  set1
    ..add('4')
    ..add('5');
  set1.forEach((item) {
    print(item);
  });

  Set<String> set2 = {'1', '2', '3', '3', '2'};
  print(set1.difference(set2)); // 补集
  print(set1.intersection(set2)); // 交集
  print(set1.union(set2)); // 并集
}
