import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaterialApp',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card示例'),
        leading: Icon(Icons.payment),
      ),
      body: ListView(
        children: <Widget>[
          MyCardWidget(
            title: 'BlendAndroid',
            subTitle: '加油',
            icon: Icons.home,
            favoriteCount: 66,
            iconBgColor: Colors.blue,
            imageAssetPath: 'lib/flutter/images/ic_fu.png',
          ),
          MyCardWidget(
            title: 'BlendAndroid',
            subTitle: '相信自己',
            icon: Icons.home,
            favoriteCount: 77,
            iconBgColor: Colors.orange,
            imageAssetPath: 'lib/flutter/images/ic_fu.png',
          ),
          MyCardWidget(
            title: 'BlendAndroid',
            subTitle: '很棒',
            icon: Icons.home,
            favoriteCount: 89,
            iconBgColor: Colors.red,
            imageAssetPath: 'lib/flutter/images/ic_man.png',
          ),
          buildCard(),
//          buildCard(),
//          buildCard(),
        ],
      ),
    );
  }

  Widget buildCard() {
    return Container(
      // 这里设置是没有用的
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.all(Radius.circular(15.0)),
      // ),
      child: Card(
        // Card设置圆角
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset(
                'lib/flutter/images/ic_man.png',
                // 用于表示一个无穷大的双精度浮点数。它可以用于指定一个小部件在某个方向上的尺寸，以便尽可能地占用可用空间
                // 也就是图片宽占满空间
                width: double.infinity,
                height: 150.0,
                // 完全填充容器，超出容器的范围会裁掉
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: <Widget>[
                // Padding:可以用于在其子组件周围添加指定大小的间距，以调整子组件与父组件之间的距离。
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Icon(Icons.home),
                  ),
                ),
                // Expanded: 可以用于将子组件扩展以填充可用空间，以及根据可用空间的大小调整子组件的尺寸
                // 能用于占满剩余的空间
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '棒棒的',
                        style: TextStyle(fontSize: 22.0),
                      ),
                      Text(
                        '500',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.favorite,
                        color: Color(0xffff0000),
                      ),
                      Text('66'),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// 自定义组件
class MyCardWidget extends StatelessWidget {
  final String imageAssetPath;
  final IconData? icon;
  final Color? iconBgColor;
  final String title;
  final String subTitle;
  final int? favoriteCount;

  const MyCardWidget(
      {Key? key,
      required this.imageAssetPath,
      this.icon,
      this.iconBgColor,
      required this.title,
      required this.subTitle,
      this.favoriteCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: Card(
        // Card设置圆角
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        elevation: 10.0,
        child: Column(
          children: <Widget>[
            Image.asset(
              imageAssetPath,
              width: double.infinity,
              height: 150.0,
              fit: BoxFit.cover,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: iconBgColor,
                      borderRadius:
                          BorderRadius.all(const Radius.circular(15.0)),
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      Text(
                        subTitle,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 2.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white,
                        Colors.grey,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      ),
                      Text(
                        '$favoriteCount',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
