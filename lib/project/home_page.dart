import 'package:flutter/material.dart';
import 'package:flutter_study_app/project/pages/discovery_page.dart';
import 'package:flutter_study_app/project/pages/news_list_page.dart';
import 'package:flutter_study_app/project/pages/profile_page.dart';
import 'package:flutter_study_app/project/pages/tweet_page.dart';
import 'package:flutter_study_app/project/widget/my_drawer.dart';
import 'package:flutter_study_app/project/widget/navigation_icon_view.dart';

import 'constants/constants.dart';

class ProjectHomePage extends StatefulWidget {
  const ProjectHomePage({Key? key}) : super(key: key);

  @override
  _ProjectHomePageState createState() => _ProjectHomePageState();
}

class _ProjectHomePageState extends State<ProjectHomePage> {
  final _appBarTitle = ['资讯', '动弹', '发现', '我的'];
  List<NavigationIconView>? _navigationIconViews;
  var _currentIndex = 0;

  List<Widget>? _pages;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _navigationIconViews = [
      NavigationIconView(
          title: '资讯',
          iconPath: 'assets/images/ic_nav_news_normal.png',
          activeIconPath: 'assets/images/ic_nav_news_active.png'),
      NavigationIconView(
          title: '动弹',
          iconPath: 'assets/images/ic_nav_tweet_normal.png',
          activeIconPath: 'assets/images/ic_nav_tweet_active.png'),
      NavigationIconView(
          title: '发现',
          iconPath: 'assets/images/ic_nav_discover_normal.png',
          activeIconPath: 'assets/images/ic_nav_discover_active.png'),
      NavigationIconView(
          title: '我的',
          iconPath: 'assets/images/ic_nav_my_normal.png',
          activeIconPath: 'assets/images/ic_nav_my_press.png'),
    ];

    _pages = [
      NewsListPage(),
      TweetPage(),
      DiscoveryPage(),
      ProfilePage(),
    ];

    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          _appBarTitle[_currentIndex],
          style: TextStyle(color: AppColors.APPBAR),
        ),
        iconTheme: IconThemeData(color: AppColors.APPBAR),
      ),
      body: PageView.builder(
        //禁止滑动
        // physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return _pages![index];
        },
        controller: _pageController,
        itemCount: _pages?.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _navigationIconViews!.map((view) => view.item).toList(),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController?.animateToPage(index,
              duration: Duration(microseconds: 1), curve: Curves.ease);
        },
      ),
      drawer: MyDrawer(
        headImgPath: 'assets/images/ic_cover_img.jpg',
        menuIcons: [Icons.send, Icons.home, Icons.error, Icons.settings],
        menuTitles: ['发布动弹', '动弹小黑屋', '关于', '设置'], key: ObjectKey("MyDrawer"),
      ),
    );
  }
}
