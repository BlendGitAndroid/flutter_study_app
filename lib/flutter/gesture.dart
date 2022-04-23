import 'package:flutter/material.dart';

//手势监测
void main() => runApp(MaterialApp(
      // home: ButtonGesture(),
      home: DismissibleGesture(),
    ));

//滑动删除
class DismissibleGesture extends StatelessWidget {
  final List<String> items = List.generate(20, (index) => 'item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          //每一个子Item
          return Dismissible(
            //监听滑动删除
            onDismissed: (_) {
              items.removeAt(index);
            },
            //滑动删除间隔时间
            movementDuration: Duration(milliseconds: 100),
            key: Key(item),
            child: ListTile(
              title: Text('$item'),
            ),
            background: Container(
              color: Color(0xffff0000),
            ),
          );
        },
      ),
    );
  }
}

//点击事件
class ButtonGesture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MyButton(),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //给Container添加点击事件
      onTap: () {
        print('onTap');
      },
      child: Container(
        //添加装饰
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.deepOrange,
        ),
        padding: EdgeInsets.all(20.0),
        child: Text('MyButton'),
      ),
    );
  }
}
