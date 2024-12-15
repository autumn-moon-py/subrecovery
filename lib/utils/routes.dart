import 'package:flutter/material.dart';

import '../page/about/about_page.dart';
import '../page/chapter/chapter_page.dart';
import '../page/chat/chat_page.dart';
import '../page/debug/debug_page.dart';
import '../page/dictionary/dictionary_page.dart';
import '../page/dictionary/widget.dart';
import '../page/image/image_page.dart';
import '../page/image/widget.dart';
import '../page/load/load_page.dart';
import '../page/setting/setting_page.dart';
import '../page/trend/trend_page.dart';

class MyRoute {
  static final routes = {
    '/load': (context) => const LoadPage(),
    '/chat': (context) => const ChatPage(),
    '/trend': (context) => const TrendPage(),
    '/image': (context) => const ImagePage(),
    '/dic': (context) => const DictionaryPage(),
    '/image_view': (context) => const ImageView(),
    '/dic_view': (context) => const DictionaryView(),
    '/setting': (context) => const SettingPage(),
    '/chapter': (context) => const ChapterPage(),
    '/about': (context) => const AboutPage(),
    '/debug': (context) => const DebugPage(),
  };
  static void to(BuildContext context, String name, [Object? arg]) {
    Navigator.pushNamed(context, name, arguments: arg);
  }

  static void back(BuildContext context) {
    Navigator.of(context).pop(context);
  }

  //跳转到指定页面无法返回
  static void off(BuildContext context, String name, [Object? arg]) {
    Navigator.pushNamedAndRemoveUntil(context, name, (route) => false,
        arguments: arg);
  }
}
