import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_study_app/project/pages/shake_page.dart';

import '../constants/constants.dart';
import 'common_web_page.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  List<Map<String, IconData>> blocks = [
    {
      '开源众包': Icons.pageview,
      '码云推荐': Icons.screen_share,
      '线下活动': Icons.local_activity,
      '软件分类': Icons.class_sharp,
    },
    {
      '扫一扫': Icons.camera_alt,
      '摇一摇': Icons.handshake,
    },
    {
      '划水排行榜': Icons.person,
      '精选开源软件': Icons.android,
    }
  ];

  _scan() {
    try {
      BarcodeScanner.scan().then(
          (value) => print("Discovery BarcodeScanner: " + value.rawContent));
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  void _handleItemClick(String title) {
    switch (title) {
      case '开源众包':
        _navToWebPage(title, 'https://zb.oschina.net/');
        break;
      case '扫一扫':
        _scan();
        break;
      case '摇一摇':
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ShakePage()));
        break;
    }
  }

  void _navToWebPage(String title, String url) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CommonWebPage(
              title: title,
              url: url,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        //分成三块
        itemCount: blocks.length,
        itemBuilder: (context, blockIndex) {
          return Container(
            //每一块的垂直边距为10
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            //每一块的装饰
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1.0,
                  color: AppColors.APP_GRAY,
                ),
                bottom: BorderSide(
                  width: 1.0,
                  color: AppColors.APP_GRAY,
                ),
              ),
            ),
            // ListView嵌套ListView，使用的是分隔器构建器（separatorBuilder）来生成一个带有分隔符的列表
            child: ListView.separated(
                // 底层的ListView不滑动，滑动冲突
                physics: NeverScrollableScrollPhysics(),
                // 当shrinkWrap设置为true时，列表或网格的尺寸将根据其内容来收缩
                shrinkWrap: true,
                itemCount: blocks[blockIndex].length,
                itemBuilder: (context, mapIndex) {
                  //水波纹组件
                  return InkWell(
                    onTap: () {
                      _handleItemClick(
                          blocks[blockIndex].keys.elementAt(mapIndex));
                    },
                    child: Container(
                      height: 60.0,
                      // 每一个item的效果,使用默认的ListTile
                      child: ListTile(
                        leading:
                            Icon(blocks[blockIndex].values.elementAt(mapIndex)),
                        title:
                            Text(blocks[blockIndex].keys.elementAt(mapIndex)),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  );
                },
                //每一个分割线的颜色
                separatorBuilder: (context, mapIndex) {
                  return Divider(
                    height: 2.0,
                    color: AppColors.APPBAR,
                  );
                }),
          );
        });
  }
}
