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
                // GridViewCount()

                GridViewBuildWidget()));
  }

  GridView GridViewCount() {
    return GridView.count(
      crossAxisCount: 2, //交叉轴个数,即一行的个数
      // scrollDirection: Axis.horizontal, //改为水平方向
      childAspectRatio: 3 / 4, //用于指定子组件的宽高比。它决定了子组件在布局中的宽度与高度之间的比例关系,默认是1.0
      children: List.generate(100, (index) {
        return Container(
          color: Colors.teal,
          margin: EdgeInsets.all(5.0),
          child: Text(
            '$index',
            style: TextStyle(fontSize: 20.0, color: Colors.deepOrange),
          ),
        );
      }),
    );
  }
}

class GridViewBuildWidget extends StatelessWidget {
  const GridViewBuildWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        // 用于创建固定交叉轴方向上的网格布局
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // - `crossAxisCount`：必需的参数，指定每行（或列，取决于滚动方向）显示的子组件数量。
          // - `mainAxisSpacing`：可选参数，指定主轴方向（水平方向或垂直方向）上子组件之间的间距。
          // - `crossAxisSpacing`：可选参数，指定交叉轴方向（垂直方向或水平方向）上子组件之间的间距。
          // - `childAspectRatio`：可选参数，指定子组件的宽高比。
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
        });
  }
}
