import 'dart:convert';

///map
main() {
  var map1 = <String, dynamic>{'name': 'blend', 'age': 20, 'weight': 120};
  print(map1);

  ///map转换成json
  var jsonStr = jsonEncode(map1);
  print(jsonStr);

  ///遍历
  map1['address'] = 'hu nan chang sha';
  map1.forEach((key, val) => print("$key : $val"));
}
