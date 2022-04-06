///集合 list and set
main() {
  /// 定义list
  //TODO 现在的List的定义
  // List<String> list = List(); // 不推荐
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
  ls.forEach((item) => print(item));

  /// 元素不可重复列表
  print('--' * 50);
  Set<String> set1 = {'1', '2', '3', '3', '2'};
  print(set1); // 会去除重复元素
  set1.forEach((item) => print(item));

  print('-' * 80);
  set1
    ..add('123')
    ..add('456');
  set1.forEach((item) {
    print(item);
  });
}
