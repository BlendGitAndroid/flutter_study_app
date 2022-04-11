class Library2 {
  String name;
  static Library2? _cache; //工厂构造函数无法访问 this。所以这里要静态的

  factory Library2([String name = 'singleton']) =>
      Library2._cache ??= Library2._newObject(name);

//定义一个命名构造函数用来生产实例
  Library2._newObject(this.name);
}

class Test {
  void test() => print('Test');
}
