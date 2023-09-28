import 'package:flutter/material.dart';

void main() => runApp(ListViewApp());

class ListViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ListView示例'),
        ),
        body:
            // new NormalListView(),
            // new HorizontalListView(),
            BuilderListView(),
      ),
    );
  }
}

class BuilderListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // builder不会一次性加载所有item
    return ListView.builder(
        // 会有懒加载,一个界面只能显示10个item,那么他会加载14个item,提前加载4个,提供滑动性能
        itemCount: 100,
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return Divider();
          }
          print('$index');
          return ListTile(
            leading: Icon(Icons.favorite_border),
            title: Text('第$index同学'),
            subtitle: Text('棒棒的！'),
            trailing: Icon(Icons.arrow_forward_ios),
          );
        });
  }
}

class HorizontalListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      // 改为水平方向
      scrollDirection: Axis.horizontal,
      //一次性加载所有item
      children: List.generate(100, (index) {
        //会有点卡顿，因为会一次性的全部生成
        return Text(
          '$index',
          style: TextStyle(fontSize: 20.0),
        );
      }),
    );
  }
}

class NormalListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.favorite_border),
          title: Text('favorite_border'),
          subtitle: Text('favorite_border'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        // 分割线
        Divider(),
        ListTile(
          leading: Icon(Icons.favorite_border),
          title: Text('favorite_border'),
          subtitle: Text('favorite_border'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.favorite_border),
          title: Text('favorite_border'),
          subtitle: Text('favorite_border'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.favorite_border),
          title: Text('favorite_border'),
          subtitle: Text('favorite_border'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
