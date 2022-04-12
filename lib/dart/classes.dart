///类以及接口
main() {
  var mall = Mall('Blend', 20, 'hu nan');
  mall.sayHi();

  print(mall.nickname);
  mall.showNickname();

  var cl1 = HttpClient();
  var cl2 = HttpClient();
  print(identical(cl1, cl2));

  var req = Request('http://www.baidu.com', 'post');
  req.showInfo();

  var httpReq = HttpRequest('http://www.baidu.com');
  httpReq.showInfo();
}

///定义接口
abstract class Animal {
  void sayHi();
}

//定义抽象类
abstract class Buy {
  void buyProduct();
}

///定义抽象类，实现接口
abstract class Person implements Animal {
  String name;
  int age;
  String address;

  Person(this.name, this.age, this.address);
}

///定义类
class PersonInfo {
  String nickname = 'blend';

  void showNickname() {
    print('show nickname $nickname');
  }
}

///实现多继承
class Mall extends Person with Buy, PersonInfo {
  Mall(String name, int age, String address) : super(name, age, address);

  @override
  void buyProduct() {
    print('buy product');
  }

  @override
  void sayHi() {
    print('my name is $name, age is $age, now address $address');
  }
}

///单例
class HttpClient {
  static final HttpClient _client = HttpClient._internal();

  //私有构造函数
  HttpClient._internal();

  factory HttpClient() {
    return _client;
  }
}

/// 可选参数类型1
class Request {
  String method;
  String url;
  Map<String, dynamic> params;

  Request(this.url,
      [this.method = 'get', this.params = const {'header': 'token'}]);

  void showInfo() {
    print('method $method --> url = $url --> params = $params');
  }
}

/// 可选参数类型2
class HttpRequest {
  String method;
  String url;

  Map<String, dynamic> params;

  //这里的map传值，必须为const
  HttpRequest(this.url,
      {this.method = 'get', this.params = const {'header': 'token'}});

  void showInfo() {
    print('method $method --> url = $url --> params = $params');
  }
}
