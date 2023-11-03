import 'dart:collection';

import 'package:flutter/scheduler.dart';

import 'isolate_handle.dart';

/// 设备信息
String? deviceInfo;

/// 报错的当前所有帧信息
ListQueue<FrameTiming> frames = ListQueue<FrameTiming>(100);

/// 当前路由的帧信息
ListQueue<FrameTiming> routerFrames = ListQueue<FrameTiming>();

/// 数据上报累
///
/// 处理各类 pv 和异常上报
class Report {
  /// 启动监听数据
  static void start() async {
    deviceInfo = await IsolateHandle.getDeviceInfo();
    // 获取每一帧耗时，这段代码主要是在 Flutter 绘制完成每一帧后都会进行回调处理，通过回调的方式可以采集到每一帧的耗时信息
    SchedulerBinding.instance.addTimingsCallback(_onReportTimings);
  }

  /// 数据处理
  /// FrameTiming用于表示每一帧的时间信息。它包含了一些与帧率和性能相关的属性
  static void _onReportTimings(List<FrameTiming> timings) {
    for (FrameTiming timing in timings) {
      frames.addFirst(timing);
      routerFrames.addFirst(timing);
    }
  }

  /// 开始计算页面的fps
  static void startRecord(String routerName) {
    routerFrames.clear();
  }

  /// 结束并显示数据
  static void endRecord(String routerName) {
    if (deviceInfo != null) {
      IsolateHandle.calculateFps(routerFrames, routerName, deviceInfo!);
      routerFrames.clear();
    }
  }
}
