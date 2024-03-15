import 'package:flutter/material.dart';

//手势监测
void main() => runApp(MaterialApp(
      home: ButtonGesture(),
      // home: DismissibleGesture(),
    ));

//滑动删除
class DismissibleGesture extends StatelessWidget {
  // 生成20个item
  final List<String> items = List.generate(20, (index) => 'item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          // `Dismissible`的常用属性包括：
          // - `key`：一个`Key`类型的值，用于唯一标识`Dismissible`小部件。
          // - `child`：一个小部件，表示要被移除的内容。
          // - `background`：一个小部件，表示在用户滑动时显示的背景内容。
          // - `secondaryBackground`：一个小部件，表示在用户从另一侧滑动时显示的背景内容。
          // - `confirmDismiss`：一个回调函数，用于确定是否允许移除小部件。
          // - `onDismissed`：一个回调函数，当小部件被移除时调用。
          return Dismissible(
            //监听滑动删除
            onDismissed: (_) {
              // 在数据源中删除
              items.removeAt(index);
            },
            //滑动删除间隔时间
            movementDuration: Duration(milliseconds: 100),
            key: Key(item),
            // ListView每个Item的内容
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
    // GestureDetector手势监测
    return GestureDetector(
      //给Container添加点击事件
      // 这里都是匿名函数
      onTap: () {
        print('onTap');
      },
      onDoubleTap: () {
        print('onDoubleTap');
      },
      child: Container(
        //添加装饰
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.deepOrange,
        ),
        padding: EdgeInsets.all(20.0),
        child: Text('MyButton'),
      ),
    );
  }
}
