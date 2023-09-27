///内置类型
main() {
  /// ---------------------------------Numbers数值:num, int, double--------------------------------
  /// int：整数值
  /// double：64位双精度浮点数
  /// int和double是num的子类
  print('-----------------------Numbers------------------------');
  int i = 3; //整数值
  double d = 1.0; //double  64-bit (双精度) 浮点数
  int bitLength = i.bitLength;
  print('bitLength: $bitLength'); //bitLength返回存储该整数所需的最小位数
  double maxFinite = double.maxFinite;
  print('maxFinite: $maxFinite'); //maxFinite double的最大值,是用static const定义的
  //int和double都是num的子类
  num n1 = 1;
  num n2 = 1.0;
  //支持十进制、十六进制
  int i1 = 0xfff;
  //科学计数法
  double d1 = 1.2e2; //120.0
  //转换
  //String->int
  int i2 = int.parse('1');
  int? i22 = int.tryParse('1.0');
  print('i2: $i2 -- i22: $i22');
  double d2 = 1; //当double的值为int值时，int自动转成double
  print('d2: $d2');

  //int->String
  String str = 123.toString(); //数字也是对象
  print('-----------------------Numbers------------------------');

  /// ---------------------------------Strings字符串:String--------------------------------
  print('-----------------------Strings------------------------');
  //Dart 字符串是 UTF-16 编码的字符序列，可以使用单引号或者双引号来创建字符串
  var name = 'blend';
  //可以在字符串中使用表达式： ${expression},如果表达式是一个标识符，可以省略 {}。 如果表达式的结果为一个对象，则 Dart 会调用对象的 toString() 函数来获取一个字符串
  var names = 'android $name';
  var rawNames = r'android ${name}'; //r 前缀可以创建一个 “原始 raw” 字符串
  print('names: $names');
  print('rawNames: $rawNames');
  //如果表达式的结果为一个对象，则 Dart 会调用对象的 toString() 函数来获取一个字符串。
//  print(Map);
  //可以使用三个单引号或者双引号也可以 创建多行字符串对象
  var multiLinesString = '''
  android
  blend''';
  print('multiLinesString: $multiLinesString');

  //StringBuffer
  var sb = StringBuffer(); //dart2 可以省略new
  sb
    ..write('aaa')
    ..write('bbb')
    ..write('ccc'); //..级联符实现链式调用
  sb.writeAll(['ddd', 'eee', 'fff'], ','); //第二个参数表示分隔符，将第一个参数列表里的数据用这个分隔符拼接起来
  print('sb: $sb');
  print('-----------------------Strings------------------------');

  /// ---------------------------------Booleans布尔值:bool--------------------------------
  print('-----------------------Booleans------------------------');
  //bool :true 和false
  bool isNull;
  // print('isNull: $isNull');  报错，为null
  print('-----------------------Booleans------------------------');

  /// ---------------------------------Lists列表(数组):List--------------------------------
  print('-----------------------Lists------------------------');
  //声明
  //自动长度，[]默认是List类型
  List growableList = [];
  growableList
    ..add(1)
    ..add(2)
    ..add('blend');
  print('growableList: $growableList');
  //固定长度
  var list = List.filled(5, 0); //List的声明，可以用var也可用List。
  list[0] = 1; //下标索引从0开始
  list[1] = 2;
  // list[2] = 'blend'; 报错，这里是String
  print('list: $list');
  //元素类型固定
  var typeList = List<int>.empty(growable: true);
  typeList.add(1);
  typeList.add(2);
  typeList.add(3);
  print('typeList: $typeList');
  //常用属性
  int first = typeList.first;
  print('typeList.first: $first'); //第一个元素
  int last = typeList.last;
  print('typeList.last: $last'); //最后一个元素
  int length = typeList.length;
  print('typeList.length: $length'); //元素个数
  bool isEmpty = typeList.isEmpty;
  print('typeList.isEmpty: $isEmpty'); //是否为空
  bool isNotEmpty = typeList.isNotEmpty;
  print('typeList.isNotEmpty: $isNotEmpty'); //是否不为空
  Iterable reversed = typeList.reversed;
  print('typeList.reversed: $reversed'); //倒序
  //常用方法 增删改查，排序，洗牌，复制子列表
  var list4 = [];
  //增
  list4.add(1);
  print('add 1 :$list4');
  list4.addAll([2, 3, 4]);
  print('addAll [2, 3, 4] :$list4');
  list4.insert(0, 0);
  print('insert(0, 0) :$list4');
  list4.insertAll(1, [5, 6, 7]);
  print('insertAll(1, [5, 6, 7]) :$list4');
  //删
  list4.remove(5);
  print('remove 5 :$list4');
  list4.removeAt(2);
  print('remove at 0 :$list4');
  //改
  list4[4] = 5;
  print('update list4[4] to 5 :$list4}');
  //range，从0开始，3个元素用9填充
  list4.fillRange(0, 3, 9);
  print('fillRange update list4[0]-list4[2] to 9 :$list4}');
  Iterable getRange = list4.getRange(0, 3);
  print('getRange list4[0]-list4[2] :$getRange}');
  //查
  var contains = list4.contains(5);
  print('list4 contains 5 :$contains');

  // indexOf 返回满足条件的第一个元素的索引，如果没有元素满足条件则返回-1
  var indexOf = list4.indexOf(1);
  print('list4 indexOf 1 :$indexOf');

  // indexWhere 返回满足条件的第一个元素的索引，如果没有元素满足条件则返回-1
  int indexWhere = list4.indexWhere((test) => test == 5);
  print('list4 indexWhere 5 :$indexWhere');

  //排序
  list4.sort();
  print('list4 sort :$list4');
  //洗牌
  list4.shuffle();
  print('list4 shuffle :$list4');

  // 返回一个新列表，其中包含 [start] 和 [end] 之间的元素
  // 如果 [end] 超出范围，则使用列表的长度作为 [end]
  var list5 = list4.sublist(1);
  print('sublist(1) list5 :$list5');
  //操作符
  var list6 = [8, 9];
  print('list6 :$list6');
  var list7 = list5 + list6;
  print('list5 + list6 :$list7');
  print('-----------------------Lists------------------------');

  /// ---------------------------------Maps键值对集合:Map--------------------------------
  print('-----------------------Maps------------------------');
  //声明
  //动态类型
  var dynamicMap = Map();
  dynamicMap['name'] = 'android';
  dynamicMap[1] = 'android';
  print('dynamicMap :$dynamicMap');
  //强类型
  var map = Map<int, String>();
  map[1] = 'android';
  map[2] = 'flutter';
  print('map :$map');
  //也可以这样声明，因为{}默认是Map类型
  var map1 = {'name': 'android', 1: 'android'};
  map1.addAll({'name': 'blend'});
  print('map1 :$map1');
  //常用属性
  print(map.isEmpty); //是否为空
  print(map.isNotEmpty); //是否不为空
  print(map.length); //键值对个数
  print(map.keys); //key 集合
  print(map.values); //value集合

  //常用方法 增删改查
  print('-----------------------Maps------------------------');

  /// ---------------------------------Sets集合:Set--------------------------------
  print('-----------------------Sets------------------------');
  //6.  Set无重复列表
  var dynamicSet = Set();
  dynamicSet.add('android');
  dynamicSet.add('flutter');
  dynamicSet.add(1);
  dynamicSet.add(1);
  print('dynamicSet :$dynamicSet');
  //常用属性与list类似

  //常用方法 增删改查与list类似
  var set1 = {'android', 'flutter'};
  print('set1 :$set1');
  var set2 = {'android', 'blend', 'dart'};
  print('set2 :$set2');
  var difference12 = set1.difference(set2);
  var difference21 = set2.difference(set1);
  print('set1 difference set2 :$difference12'); //返回set1集合里有但set2里没有的元素集合
  print('set2 difference set1 :$difference21'); //返回set2集合里有但set1里没有的元素集合
  var intersection = set1.intersection(set2);
  print('set1 set2交集 :$intersection'); //返回set1和set2的交集
  var union = set1.union(set2);
  print('set1 set2并集 :$union'); //返回set1和set2的并集
  set2.retainAll(['android', 'flutter']); //只保留(要保留的元素要在原set中存在）
  print('set2只保留android flutter :$set2');
  print('-----------------------Sets------------------------');

  /// ---------------------------------Runes符号字符--------------------------------
  //Runes用于在字符串中表示Unicode字符 https://copychar.cc/emoji/
  String runesStr = '👄';
  print(runesStr);
  print(runesStr.length); //表示占 2 个 16 位字符
  print(runesStr.runes.length); //表示占 1 个 32 位字符

  Runes runes = new Runes('\u{1f605} \u6211');
  var str1 = String.fromCharCodes(runes); //使用String.fromCharCodes显示字符图形
  print(str1);
  String str2 = '\u{1f605} \u6211'; //直接输出字符图形
  print(str2);

  /// ---------------------------------Symbols标识符--------------------------------
  //Symbol标识符 主要是反射用，现在mirrors已经被移除了
}
