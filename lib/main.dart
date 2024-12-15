import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'page/chat/chat_view_model.dart';
import 'page/debug/debug_view_model.dart';
import 'page/dictionary/dictionary_view_model.dart';
import 'page/image/image_view_model.dart';
import 'page/setting/setting_view_model.dart';
import 'page/trend/trend_view_model.dart';
import 'utils/routes.dart';

class EnvironmentConfig {
  static const appChannel = String.fromEnvironment('appChannel');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemUiOverlayStyle systemUiOverlayStyle =
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
        size: Size(500, 800),
        center: true,
        titleBarStyle: TitleBarStyle.hidden);
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ChatViewModel>(create: (_) => ChatViewModel()),
          ChangeNotifierProvider<DictionaryViewModel>(
              create: (_) => DictionaryViewModel()),
          ChangeNotifierProvider<ImageViewModel>(
              create: (_) => ImageViewModel()),
          ChangeNotifierProvider<ImageViewModel>(
              create: (_) => ImageViewModel()),
          ChangeNotifierProvider<SettingViewModel>(
              create: (_) => SettingViewModel()),
          ChangeNotifierProvider<TrendViewModel>(
              create: (_) => TrendViewModel()),
          ChangeNotifierProvider<DebugViewModel>(
              create: (_) => DebugViewModel()),
        ],
        child: ScreenUtilInit(
            designSize: const Size(1080, 1920),
            builder: (context, _) {
              return GetMaterialApp(
                  title: '异次元通讯',
                  theme: ThemeData(useMaterial3: false),
                  debugShowCheckedModeBanner: false,
                  builder: EasyLoading.init(),
                  initialRoute: '/load',
                  routes: MyRoute.routes);
            }));
  }
}
