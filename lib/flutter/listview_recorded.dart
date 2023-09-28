import 'package:flutter/material.dart';

//拖拽移动位置
void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List list = List.generate(15, (i) => 'Item $i');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('listview recorded'),
      ),
      // ReorderableListView是一个可重新排序项目的可滚动列表组件，可以让用户通过拖动来重新排列列表中的项目
      body: ReorderableListView(
        onReorder: _onReorder,
        children: list
            .map((m) => ListTile(
                  key: ObjectKey(m),
                  title: Text(m),
                ))
            .toList(),
      ),
    );
  }

  _onReorder(int oldIndex, int newIndex) {
    print('oldIndex: $oldIndex, newIndex: $newIndex');
    setState(() {
      //如果 [oldIndex] 在 [newIndex] 之前，则从列表中删除 [oldIndex] 处的项目会将列表的长度减少一。
      // 在 [newIndex] 之前插入时，实现需要考虑到这一点。所以这里的[newIndex]也要减一
      if (oldIndex < newIndex) {
        newIndex = newIndex - 1;
      }
      //交换位置，先移除再插入
      var item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
    });
  }
}
