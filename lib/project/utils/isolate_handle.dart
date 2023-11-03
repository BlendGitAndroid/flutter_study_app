import 'dart:collection';
import 'dart:isolate';
import 'dart:ui';

/// 保存当前 isolate 连接
Isolate? isolate;

/// 主线程向isolate连接句柄
var sendPort;

/// 线程处理模块
///
/// 新线程处理性能上报和分析
class IsolateHandle {
  /// 计算并上报fps
  static calculateFps(ListQueue<FrameTiming> routerFrames, String routerName,
      String deviceInfo) {
    _sendMsg('calculateFps', routerFrames, routerName, deviceInfo);
  }

  /// 发送消息给到 isolate
  static void _sendMsg(String callFun, ListQueue<FrameTiming> routerFrames,
      String routerName, String deviceInfo) async {
    // 创建一个接收端口，用于接收 isolate 的回传消息
    var receivePort = ReceivePort();

    if (isolate == null) {
      // 创建新的 isolate，并把当前的发送端口传递过去
      isolate = await Isolate.spawn(_otherIsolate, receivePort.sendPort);
    }
    Map dataInfo = {
      'fun': callFun,
      'routerFrames': routerFrames,
      'routerName': routerName,
      'deviceInfo': deviceInfo,
    };
    if (sendPort != null) {
      // 如果已经连接成功，则直接使用 sendPort 向isolate发送消息
      sendPort.send(dataInfo);
    }
    receivePort.listen((data) {
      if (data is SendPort) {
        // 拿到 isolate 的发送端口，用于向 isolate 发送消息
        sendPort = data;
        return;
      }
      print("receivePort.listen: $data");
      sendPort.send(dataInfo);
    });
  }

  /// 其他线程，处理计算和上报
  static void _otherIsolate(SendPort sendPort) {
    // isolate 的接收端口
    var receivePort = ReceivePort();
    // 监听主线程的消息
    receivePort.listen((data) {
      if (data['fun'] == 'calculateFps') {
        _isolateCalculateFps(data['routerFrames'] as ListQueue<FrameTiming>,
            data['routerName'] as String, data['deviceInfo'] as String);
      }
      if (data['fun'] == 'reportPv') {
        _isolateReportPv(
            data['routerName'] as String, data['deviceInfo'] as String);
      }
    });
    // 把 isolate 的的发送端口传递给主线程
    sendPort.send(receivePort.sendPort);
    // 再发送回包，处理具体的信息
    sendPort.send('success');
  }

  /// 这里上报 页面浏览量 数据
  static void _isolateReportPv(String routerName, String deviceInfo) async {
    print('$deviceInfo\t上报页面浏览量：$routerName');
  }

  /// 计算当个页面的 fps
  static void _isolateCalculateFps(ListQueue<FrameTiming> calculateList,
      String routerName, String deviceInfo) {
    String fpsStr = 60.toStringAsFixed(3);
    // 丢失的帧数
    int lostNum = 0;
    // flutter 标准渲染频率
    double standardFps = 1000 / 60;
    // 计算多少出现掉帧情况，请注意如果是 33秒，其掉帧为2，用34/16。67下取整。
    calculateList.forEach((frame) {
      // frame.totalSpan  总耗时
      if (frame.totalSpan.inMilliseconds > standardFps) {
        // 超出 16ms 的帧
        lostNum =
            lostNum + (frame.totalSpan.inMilliseconds / standardFps).floor();
      }
    });
    // 计算fps
    if (calculateList.length + lostNum > 0) {
      // 尽量避免分母为0情况,计算fps
      double fps =
          (60 * calculateList.length) / (calculateList.length + lostNum);
      fpsStr = fps.toStringAsFixed(3);
    }
    print('$deviceInfo\t页面：$routerName\tfps：$fpsStr');
  }

  /// 获取设备信息
  static Future<String> getDeviceInfo() async {
    return '平台:Android\t版本:1.0.0';
  }
}
