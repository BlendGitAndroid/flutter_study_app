import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../common/event_bus.dart';
import '../constants/constants.dart';
import '../utils/data_utils.dart';
import '../utils/net_utils.dart';
import '../widget/news_list_item.dart';
import 'log_web_page.dart';

class BlogPage extends StatefulWidget {
  bool isMyBlog = false;
  PageController? pageController;

  BlogPage({Key? key}) : super(key: key);

  @override
  _BlogPageState createState() => _BlogPageState();
}

// SingleTickerProviderStateMixin是Flutter中的一个mixin，它为State对象提供了一个单个TickerProvider的实现。
// 作用就是当前页的动画还在播放的时候，用户导航到另外一个页面，当前页的动画就没有必要再播放了，反之在页面切换回来的时
// 候动画有可能还要继续播放，它就是来实现这个控制的。
class _BlogPageState extends State<BlogPage>
    with SingleTickerProviderStateMixin {
  List _tabTitles = ['最新', '我的'];

  // 最新博客列表
  List? latestBlogList;

  // 我的博客列表
  List? myBlogList;
  int curPage = 1;

  // `ScrollController` 是一个用于控制滚动行为的类，它可以与各种可滚动组件
  // （如 `ListView`、`GridView`、`SingleChildScrollView` 等）一起使用
  ScrollController _controller = ScrollController();

  // 用于管理TabBar和TabBarView之间同步的控制器
  // TabBar和TabBarView是常用于创建分页视图的两个组件。TabBar用于显示选项卡，
  // 而TabBarView用于显示对应选项卡的内容。TabController可以控制TabBar的切换和TabBarView的滚动。
  TabController? _tabController;

  // 是否登录
  bool isLogin = false;

  Drag? drag;
  DragStartDetails? dragStartDetails;

  @override
  void initState() {
    super.initState();
    // 添加了一个选项卡切换的监听器
    _tabController = TabController(
        initialIndex: widget.isMyBlog ? 1 : 0,
        length: _tabTitles.length,
        vsync: this);
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels) {
        curPage++;
        getBlogList(isLoadMore: true);
      }
    });

    //登录登出逻辑判断
    DataUtils.isLogin().then((isLogin) {
      if (!mounted) return;
      setState(() {
        this.isLogin = isLogin;
      });
    });
    eventBus.on<LoginEvent>().listen((event) {
      if (!mounted) return;
      setState(() {
        this.isLogin = true;
      });
      getBlogList(isLoadMore: false);
    });
    eventBus.on<LogoutEvent>().listen((event) {
      this.isLogin = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //这里直接返回
    if (!isLogin) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('必须登录才能查看博客信息！'),
            InkWell(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  '马上登录',
                  style: TextStyle(color: Color(0xff0000ff)),
                ),
              ),
              onTap: () async {
                //跳转登录
                final result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginWebPage()));
                if (result != null && result == 'refresh') {
                  //登录成功
                  eventBus.fire(LoginEvent());
                }
              },
            ),
          ],
        ),
      );
    }

    //如果登录了，返回数据
    return Column(
      children: <Widget>[
        //标题
        Container(
          color: AppColors.APP_THEME,
          child: TabBar(
              controller: _tabController,
              //指示器的颜色
              indicatorColor: Color(0xffffffff),
              //tab背景色
              labelColor: Color(0xffffffff),
              tabs: _tabTitles.map((title) {
                return Tab(
                  text: title,
                );
              }).toList()),
        ),
        // Expanded: 可以用于将子组件扩展以填充可用空间，以及根据可用空间的大小调整子组件的尺寸
        Expanded(
            // 解决滑动冲突，Flutter在滑动中每次都会发起ScrollNotification相关通知，这是我们处理滑动冲突的一个思路
            child: NotificationListener(
                onNotification: (notification) {
                  if (notification is ScrollStartNotification) {
                    //滑动起始的通知先存起来
                    dragStartDetails = notification.dragDetails;
                  }
                  // 当滑动到TabBarView的最后一页（无论是左还是右的时候）系统会发出OverscrollNotification的通知
                  if (notification is OverscrollNotification) {
                    // 当发生OverScroll的时候，生成外部滑动的drag对象
                    // ScrollPosition生成一个Drag对象，这个对象发起了ScrollStartNotification,开发者可以通过监
                    // 听这个这个通知，进行一些自定义的手势处理，
                    drag = widget.pageController?.position
                        .drag(dragStartDetails!, () {});
                    //使用外部滑动的drag对象进行滑动
                    drag?.update(notification.dragDetails!);
                  }
                  if (notification is ScrollEndNotification) {
                    //滑动结束后取消
                    drag?.cancel();
                    drag = null;
                  }
                  return true;
                },
                child: TabBarView(
                  // TabBarView 封装了 PageView
                  controller: _tabController,
                  children: [_buildLatestBlogList(), _buildHotBlogList()],
                )))
      ],
    );
  }

  Future<Null> _pullToRefresh() async {
    curPage = 1;
    getBlogList(isLoadMore: false);
    return null;
  }

  //最新
  Widget _buildLatestBlogList() {
    if (latestBlogList == null) {
      getBlogList(isLoadMore: false);
      return new Center(
        child: new CircularProgressIndicator(),
      );
    }
    if (latestBlogList?.length == 0) {
      return new Center(
        child: new Text('暂无最新博客'),
      );
    }
    return RefreshIndicator(
      onRefresh: _pullToRefresh,
      child: ListView.separated(
          controller: _controller,
          itemBuilder: (context, index) {
            if (index == latestBlogList?.length) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CupertinoActivityIndicator(),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text('正在加载...'),
                  ],
                )),
              );
            }
            return NewsListItem(newsList: latestBlogList?[index], isBlog: true);
          },
          separatorBuilder: (context, index) {
            return Container(
              height: 10.0,
              color: Colors.white,
            );
          },
          itemCount: (latestBlogList?.length ?? 0) + 1),
    );
  }

  Widget _buildHotBlogList() {
    if (myBlogList == null) {
      getMyBlogList(isLoadMore: false);
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }

    if (myBlogList?.length == 0) {
      return Center(
        child: Text('您还没有写博客'),
      );
    }

    return ListView.separated(
        itemBuilder: (context, index) {
          if (index == myBlogList?.length) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.white,
              child: Center(child: Text('~快来写博客呀')),
            );
          }
          //显示具体信息
          return NewsListItem(newsList: myBlogList?[index], isBlog: true);
        },
        separatorBuilder: (context, index) {
          return Container(
            height: 10.0,
            color: Colors.white,
          );
        },
        //这里+1是因为最后要显示“没有更多数据了”
        itemCount: (myBlogList?.length ?? 0) + 1);
  }

  // 获取博客列表
  void getBlogList({required bool isLoadMore}) {
    DataUtils.isLogin().then((isLogin) {
      if (isLogin) {
        DataUtils.getAccessToken().then((accessToken) {
          if (accessToken == null || accessToken.length == 0) {
            return;
          }
          Map<String, dynamic> params = Map<String, dynamic>();
          params['access_token'] = accessToken;
          params['page'] = curPage;
          params['pageSize'] = 10;
          params['dataType'] = 'json';

          NetUtils.get(AppUrls.BLOG_LIST, params).then((data) {
            print('BLOG_LIST: $data');
            if (data.isNotEmpty) {
              Map<String, dynamic> map = json.decode(data);
              List _bloglist = map['bloglist'];
              if (!mounted) return;
              setState(() {
                if (isLoadMore) {
                  latestBlogList?.addAll(_bloglist);
                } else {
                  latestBlogList = _bloglist;
                }
              });
            }
          });
        });
      }
    });
  }

  getMyBlogList({required bool isLoadMore}) {
    DataUtils.isLogin().then((isLogin) async {
      if (isLogin) {
        var user = await DataUtils.getUserInfo();
        DataUtils.getAccessToken().then((accessToken) {
          if (accessToken == null || accessToken.length == 0) {
            return;
          }
          Map<String, dynamic> params = Map<String, dynamic>();
          params['access_token'] = accessToken;
          params['authoruid'] = user?.id;
          params['page'] = curPage;
          params['pageSize'] = 10;
          params['dataType'] = 'json';

          NetUtils.get(AppUrls.MY_BLOG_LIST, params).then((data) {
            print('MY_BLOG_LIST: $data');
            if (data.isNotEmpty) {
              Map<String, dynamic> map = json.decode(data);
              List _bloglist = map['projectlist'];
              if (!mounted) return;
              setState(() {
                if (isLoadMore) {
                  myBlogList?.addAll(_bloglist);
                } else {
                  myBlogList = _bloglist;
                }
              });
            }
          });
        });
      }
    });
  }
}
