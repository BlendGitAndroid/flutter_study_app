import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../pages/blog_detail_page.dart';
import '../pages/news_detail_page.dart';

class NewsListItem extends StatelessWidget {
  final Map<String, dynamic> newsList;
  bool isBlog;

  // 将String对象赋值给newsList,并jsonDecode
  NewsListItem({required this.newsList, this.isBlog = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isBlog) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BlogDetailPage(id: newsList['id'])));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NewsDetailPage(id: newsList['id'])));
        }
      },
      // 用Container包裹，用于装饰边框,左右边距
      child: Container(
        // 左边距20
        margin: const EdgeInsets.only(left: 20.0),
        decoration: BoxDecoration(
          // 底部边框
          border: Border(
            bottom: BorderSide(
              color: AppColors.APP_GRAY,
              width: 1.0,
            ),
          ),
        ),
        child: Padding(
          // 设置padding
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 20.0),
          child: Column(
            // 交叉轴的对齐方式,默认是居中对齐
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${newsList['title']}',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '@${newsList['author']} ${newsList['pubDate'].toString().split(' ')[0]}',
                    style: TextStyle(color: Color(0xaaaaaaaa), fontSize: 14.0),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.message,
                        color: Color(0xaaaaaaaa),
                      ),
                      Text(
                        '${newsList['commentCount']}',
                        style:
                            TextStyle(color: Color(0xaaaaaaaa), fontSize: 14.0),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
