// import 'package:fl_jpush/fl_jpush.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  late FlutterLocalNotificationsPlugin plugin;

  NotificationService._internal() {
    const initializationSettings = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings());
    plugin = FlutterLocalNotificationsPlugin();
    plugin.initialize(initializationSettings);
  }

  Future<void> newNotification(String title, String msg, bool vibration) async {
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;
    String channelName = '消息提示';
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channelName, channelName,
            importance: Importance.max,
            priority: Priority.defaultPriority,
            vibrationPattern: vibration ? vibrationPattern : null,
            enableVibration: vibration);
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails();
    var notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    await plugin.show(0, title, msg, notificationDetails);
  }
}

// class Jpush {
//   ///初始化设置
//   static Future<void> setup() async {
//     FlJPush().setup(
//         appKey: '5858a0b6bb205b2d81e6c6bb',
//         production: false,
//         channel: 'channel',
//         debug: false);
//     bool? status = await FlJPush().isNotificationEnabled();
//     debugPrint("通知权限打开状态：$status");
//     addEventHandler();
//     clearNotification();
//   }

//   ///发送本地通知
//   ///fireTime：延迟时间
//   ///badge：桌面角标数量
//   static void notification(String title, String msg, [int fireTime = 1]) {
//     final notificationID = DateTime.now().millisecondsSinceEpoch;
//     var localNotification = LocalNotification(
//         id: notificationID, title: title, content: msg, fireTime: fireTime);
//     FlJPush().sendLocalNotification(
//         android: localNotification.toAndroid(), ios: localNotification.toIOS());
//   }

//   /// 清空通知栏上全部本地通知
//   static Future<void> clearNotification() async {
//     await FlJPush().clearNotification(clearLocal: true);
//   }

//   ///设置桌面角标数
//   static void setBadge(int badge) {
//     FlJPush().setBadge(badge);
//   }

//   ///获取uuid
//   static Future<void> getUuid() async {
//     String? udid = await FlJPush().getUDIDWithAndroid();
//     debugPrint("设置UUID：$udid");
//   }

//   ///添加监听回调
//   static Future<void> addEventHandler() async {
//     FlJPush().addEventHandler(
//         eventHandler: FlJPushEventHandler(
//             onOpenNotification: (JPushNotificationMessage? message) {
//           /// 点击通知栏消息回调
//           debugPrint('onOpenNotification: ${message?.toMap()}');
//         }, onReceiveNotification: (JPushNotificationMessage? message) {
//           /// 接收普通消息
//           debugPrint('onReceiveNotification: ${message?.toMap()}');
//         }, onReceiveMessage: (JPushMessage? message) {
//           /// 接收自定义消息
//           debugPrint('onReceiveMessage: ${message?.toMap()}');
//         }),
//         androidEventHandler: FlJPushAndroidEventHandler(
//             onCommandResult: (FlJPushCmdMessage message) {
//           debugPrint('onCommandResult: ${message.toMap()}');
//         }, onNotifyMessageDismiss: (JPushNotificationMessage? message) {
//           /// onNotifyMessageDismiss
//           /// 清除通知回调
//           /// 1.同时删除多条通知，可能不会多次触发清除通知的回调
//           /// 2.只有用户手动清除才有回调，调接口清除不会有回调
//           debugPrint('onNotifyMessageDismiss: ${message?.toMap()}');
//         }, onNotificationSettingsCheck:
//                 (FlJPushNotificationSettingsCheck? settingsCheck) {
//           /// 通知开关状态回调
//           /// 说明: sdk 内部检测通知开关状态的方法因系统差异，在少部分机型上可能存在兼容问题(判断不准确)。
//           /// source 触发场景，0 为 sdk 启动，1 为检测到通知开关状态变更
//           debugPrint('onNotificationSettingsCheck: ${settingsCheck?.toMap()}');
//         }),
//         iosEventHandler: FlJPushIOSEventHandler(
//             onReceiveNotificationAuthorization: (bool? state) {
//           /// ios 申请通知权限 回调
//           debugPrint('onReceiveNotificationAuthorization: $state');
//         }, onOpenSettingsForNotification: (JPushNotificationMessage? data) {
//           /// 从应用外部通知界面进入应用是指 左滑通知->管理->在“某 App”中配置->进入应用 。
//           /// 从通知设置界面进入应用是指 系统设置->对应应用->“某 App”的通知设置
//           /// 需要先在授权的时候增加这个选项 JPAuthorizationOptionProvidesAppNotificationSettings
//           debugPrint('onOpenSettingsForNotification: ${data?.toMap()}');
//         }));
//   }
// }
