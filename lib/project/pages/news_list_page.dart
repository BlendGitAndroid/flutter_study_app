import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/event_bus.dart';
import '../constants/constants.dart';
import '../utils/data_utils.dart';
import '../utils/net_utils.dart';
import '../widget/news_list_item.dart';
import 'log_web_page.dart';

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  bool isLogin = false;
  int curPage = 1;
  List? newsList;

  // `ScrollController` 是一个用于控制滚动行为的类，它可以与各种可滚动组件
  // （如 `ListView`、`GridView`、`SingleChildScrollView` 等）一起使用
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    // 添加一个滚动监听器，
    _controller.addListener(() {
      // 获取当前滚动位置的 `ScrollPosition` 对象,用于表示当前组件滚动的位置
      // `maxScrollExtent`：获取可滚动范围的最大像素值
      // `pixels`：获取当前滚动位置的像素值
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels) {
        curPage++;
        getNewsList(true);
      }
    });

    // 判断是否登录
    DataUtils.isLogin().then((isLogin) {
      // 使用mounted来进行判断页面是否被释放
      if (!mounted) return;
      setState(() {
        this.isLogin = isLogin;
      });
    });

    // 监听登录事件
    eventBus.on<LoginEvent>().listen((event) {
      if (!mounted) return;
      setState(() {
        this.isLogin = true;
      });
      getNewsList(false);
    });

    // 监听登出事件
    eventBus.on<LogoutEvent>().listen((event) {
      if (!mounted) return;
      setState(() {
        this.isLogin = false;
      });
    });
  }

  //获取新闻列表
  getNewsList(bool isLoadMore) async {
    DataUtils.isLogin().then((isLogin) {
      if (isLogin) {
        DataUtils.getAccessToken().then((accessToken) {
          if (accessToken == null || accessToken.length == 0) {
            return;
          }
          Map<String, dynamic> params = Map<String, dynamic>();
          params['access_token'] = accessToken;
          params['catalog'] = 1;
          params['page'] = curPage;
          params['pageSize'] = 10;
          params['dataType'] = 'json';

          NetUtils.get(AppUrls.NEWS_LIST, params).then((data) {
            print('NEWS_LIST: $data');
            if (data.isNotEmpty) {
              // 将 JSON 字符串解码为 Dart 对象,并且可以根据 JSON 数据的结构动态地生成相应的 Dart 类型
              // 这里将 JSON 字符串解码为一个 Map 类型
              Map<String, dynamic> map = json.decode(data);
              List _newsList = map['newslist'];
              if (!mounted) return;
              setState(() {
                if (isLoadMore) {
                  newsList?.addAll(_newsList);
                } else {
                  newsList = _newsList;
                }
              });
            }
          });
        });
      }
    });
  }

  Future<Null> _pullToRefresh() async {
    curPage = 1;
    getNewsList(false);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // 如果没有登录，显示登录页面
    if (!isLogin) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('由于openapi限制，必须登录才能获取资讯！'),
            // 提供了一个可点击的区域，并在点击时产生一个水波纹效果
            // `InkWell` 可以包裹其他小部件，使它们具有点击的交互能力。当用户点击 `InkWell`
            // 包裹的小部件时，它会通过一个动画效果，在点击位置处生成一个水波纹效果。
            InkWell(
              onTap: () async {
                final result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginWebPage()));
                if (result != null && result == 'refresh') {
                  //登录成功,发送登录事件，通知我的界面刷新数据
                  eventBus.fire(LoginEvent());
                }
              },
              child: Text('去登录'),
            ),
          ],
        ),
      );
    }

    // 实现下拉刷新的效果
    // 可以用于包裹一个滚动视图（如 `ListView`、`GridView` 等），当用户下拉滚动视图时，
    // 可以触发刷新回调函数，并显示一个刷新指示器。
    return RefreshIndicator(
      onRefresh: _pullToRefresh,  // 下拉刷新回调
      child: buildListView(), // 要进行下拉刷新的滚动视图
    );
  }

  Widget buildListView() {
    if (newsList == null || newsList?.length == 0) {
      getNewsList(false);
      return Center(child: CupertinoActivityIndicator());
    }
    // 使用构建器模式，根据索引动态构建列表项，而不是一次性构建所有子项。这意味着只有在它们需要
    // 显示在屏幕上时，才会构建相应子项，这样可以大大提高性能和效率
    return ListView.builder(
        // 添加滚动监听器
        controller: _controller,
        itemCount: newsList?.length,
        itemBuilder: (context, index) {
          // 这里是隐式的转换
          return NewsListItem(newsList: newsList?[index]);
        });
  }
}
