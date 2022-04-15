import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('GridView示例'),
      ),
      body:
//             GridView.count(
//               crossAxisCount: 2, //交叉轴
// //            scrollDirection: Axis.horizontal, //水平
//               childAspectRatio: 3 / 4, //默认是1.0宽高比
//               children: List.generate(100, (index) {
//                 return Container(
//                   color: Colors.teal,
//                   margin: EdgeInsets.all(5.0),
//                   child: Text(
//                     '$index',
//                     style: TextStyle(fontSize: 20.0, color: Colors.deepOrange),
//                   ),
//                 );
//               }),
//             )

          GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (context, index) {
                print('$index');
                return Container(
                  color: Color(0xffff0000),
                  margin: EdgeInsets.all(5.0),
                  child: Text(
                    '$index',
                    style: TextStyle(fontSize: 20.0),
                  ),
                );
              }),
    ));
  }
}
