import 'package:flutter/material.dart';

import '../pages/about_page.dart';
import '../pages/publish_tweet_page.dart';
import '../pages/settings_page.dart';
import '../pages/tweet_black_house.dart';

class MyDrawer extends StatelessWidget {
  final String headImgPath;
  final List menuTitles;
  final List menuIcons;

  MyDrawer(
      {required Key key,
      required this.headImgPath,
      required this.menuTitles,
      required this.menuIcons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      //取消右侧的阴影
      elevation: 0.0,
      child: ListView.separated(
        padding: const EdgeInsets.all(0.0), //解决状态栏问题，将图片顶上去
        itemCount: menuTitles.length + 1, //+1为了ListView.separated
        itemBuilder: (context, index) {
          if (index == 0) {
            return Image.asset(
              headImgPath,
              fit: BoxFit.cover,
            );
          }
          index -= 1; //-1为了ListTile
          return ListTile(
            leading: Icon(menuIcons[index]),
            title: Text(menuTitles[index]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              //TODO 待实现
              switch (index) {
                case 0:
                  //PublishTweetPage
                  _navPush(context, PublishTweetPage());
                  break;
                case 1:
                  //TweetBlackHousePage
                  _navPush(context, TweetBlackHousePage());
                  break;
                case 2:
                  //AboutPage
                  _navPush(context, AboutPage());
                  break;
                case 3:
                  //SettingsPage
                  _navPush(context, SettingsPage());
                  break;
              }
            },
          );
        },
        separatorBuilder: (context, index) {
          if (index == 0) {
            return Divider(
              height: 0.0,
            );
          } else {
            return Divider(
              //分割线Widget的高，不是分割线本身效果的高,可以达到两个Widget 之间margin的效果
              height: 1.0,
            );
          }
        },
      ),
    );
  }

  _navPush(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
