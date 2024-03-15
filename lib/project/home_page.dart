import 'package:flutter/material.dart';
import 'package:flutter_study_app/project/pages/blog_page.dart';
import 'package:flutter_study_app/project/pages/discovery_page.dart';
import 'package:flutter_study_app/project/pages/news_list_page.dart';
import 'package:flutter_study_app/project/pages/profile_page.dart';
import 'package:flutter_study_app/project/utils/report.dart';
import 'package:flutter_study_app/project/widget/keep_alive_wrapper.dart';
import 'package:flutter_study_app/project/widget/my_drawer.dart';
import 'package:flutter_study_app/project/widget/navigation_icon_view.dart';

import 'common/event_bus.dart';
import 'constants/constants.dart';

class ProjectHomePage extends StatefulWidget {
  const ProjectHomePage({Key? key}) : super(key: key);

  @override
  _ProjectHomePageState createState() => _ProjectHomePageState();
}

class _ProjectHomePageState extends State<ProjectHomePage> {
  final _appBarTitle = ['资讯', '博客', '发现', '我的'];

  // 初始化一个可空的数组
  List<NavigationIconView>? _navigationIconViews;
  var _currentIndex = 0;

  List<Widget>? _pages;
  PageController? _pageController;

  bool isMyBlog = false;

  BlogPage blogPage = BlogPage();

  @override
  void initState() {
    super.initState();
    // 开始计算页面的fps
    Report.startRecord('${this.runtimeType}');

    _navigationIconViews = [
      NavigationIconView(
          title: '资讯',
          iconPath: 'assets/images/ic_nav_news_normal.png',
          activeIconPath: 'assets/images/ic_nav_news_active.png'),
      NavigationIconView(
          title: '博客',
          iconPath: 'assets/images/ic_nav_blog_normal.png',
          activeIconPath: 'assets/images/ic_nav_blog_active.png'),
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
      blogPage,
      DiscoveryPage(),
      ProfilePage(),
    ];

    _pageController = PageController(initialPage: _currentIndex);
    blogPage.pageController = _pageController;

    // 监听跳转博客事件
    eventBus.on<GotoBlogEvent>().listen((event) {
      if (!mounted) return;
      blogPage.isMyBlog = true;
      setState(() {
        this._currentIndex = 1;
        // 用于在 `PageView` 中进行页面切换的动画效果
        _pageController?.animateToPage(1,
            duration: Duration(microseconds: 1), curve: Curves.ease);
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    DateTime? _lastPressedAt; //上次点击时间

    // 单次 Frame 绘制回调，只会回调一次
    WidgetsBinding.instance
        .addPostFrameCallback((_) => Report.endRecord('${this.runtimeType}'));

    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 1)) {
          //两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
            content: new Text("请再次点击退出"),
            duration: Duration(milliseconds: 500),
          ));
          return false; // 拦截返回按钮
        }
        return true;
      },
      child: scaffoldName(),
    );
  }

  Scaffold scaffoldName() {
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
          // 为 true 后会缓存所有的列表项，列表项将不会销毁。
          // 为 false 时，列表项滑出预加载区域后将会别销毁。
          // 使用时一定要注意是否必要，因为对所有列表项都缓存的会导致更多的内存消耗
          return KeepAliveWrapper(child: _pages![index]);
        },
        controller: _pageController,
        itemCount: _pages?.length,
        // 页面切换时的回调
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        // allowImplicitScrolling: true, // 缓存前后各一页,但是这种效果不好,采用AutomaticKeepAlive
      ),
      // 底部导航栏组件
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        // `map` 方法是 `Iterable` 类的一个成员函数，用于将一个集合（如 `List` 或 `Set`）中
        // 的每个元素都映射成另一个值，并返回一个新的集合。
        // `map` 方法的语法如下：
        // Iterable<T> map<T>(T f(E e))
        // 其中，参数 `f` 是一个函数，它接受集合中的每个元素 `e`，并返回一个新的值。`map` 方法会
        // 遍历集合中的每个元素，将每个元素传递给函数 `f`，并将返回的值添加到一个新的集合中。最后返回这个新的集合。
        items: _navigationIconViews!.map((view) => view.item).toList(),
        type: BottomNavigationBarType.fixed,
        // 点击事件
        onTap: (index) {
          blogPage.isMyBlog = false;
          setState(() {
            _currentIndex = index;
          });
          // 用于在 `PageView` 中进行页面切换的动画效果
          _pageController?.animateToPage(index,
              duration: Duration(microseconds: 1), curve: Curves.ease);
        },
      ),
      // 抽屉组件
      drawer: MyDrawer(
        headImgPath: 'assets/images/ic_cover_img.png',
        menuIcons: [Icons.send, Icons.error, Icons.settings],
        menuTitles: ['写博客', '关于', '设置'],
        key: ObjectKey("MyDrawer"),
      ),
    );
  }
}
