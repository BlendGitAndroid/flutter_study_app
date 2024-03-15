///泛型
main() {
  //使用泛型，很多的容器对象，在创建对象时都可以定义泛型类型,跟java一样
  var list = [];
  list.add('aaa');
  list.add('bbb');
  list.add('ccc');
  print(list);

  var map = Map<int, String>();
  map[1] = 'aaaa';
  map[2] = 'bbbb';
  map[3] = 'cccc';
  print(map);

  //泛型函数,<K, V>就是定义泛型
  K addCache<K, V>(K key, V value) {
    K temp = key;
    print('$key: $value');
    return temp;
  }

  var key = addCache('Android', 'Flutter');
  print(key);

  //构造函数泛型
  var p = Phone<String>('123456');
  print(p.mobileNumber);

  //泛型限制， 通过 extends 关键字限定可泛型使用的类型
  var flutter = Flutter();
  var m = Android<Flutter>(flutter);
  m.android.doAndroid();

  //运行时可判断泛型
  var names = List<String>.empty(growable: true);
  print(names is List<String>);
  print(names.runtimeType);//这里没有进行类型擦除
}

//构造函数泛型
class Phone<T> {
  final T mobileNumber;

  Phone(this.mobileNumber);
}

//泛型限制
class Android<T extends Flutter> {
  final T android;

  Android(this.android);
}

class Flutter {
  void doAndroid() {
    print('Flutter');
  }
}
