import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

//登录通知
class LoginEvent {}

//登出通知
class LogoutEvent {}

// 跳转到博客详情通知
class GotoBlogEvent{}
