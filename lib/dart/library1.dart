class Library1 {
  String name;
  static Library1? _cache; //工厂构造函数无法访问 this。所以这里要静态的

  factory Library1([String name = 'singleton']) =>
      Library1._cache ??= Library1._newObject(name);

  //定义一个命名构造函数用来生产实例
  Library1._newObject(this.name);
}

class Test {
  void test() => print('Library1 Test');
  void lazy() => print('Library1 Lazy');
}
