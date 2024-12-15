// ignore_for_file: use_build_context_synchronously, unused_element

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/routes.dart';
import '../chat/chat_view_model.dart';
import '../debug/debug_view_model.dart';
import '../dictionary/dictionary_view_model.dart';
import '../image/image_view_model.dart';
import '../setting/setting_view_model.dart';
import '../trend/trend_view_model.dart';

class LoadPage extends StatefulWidget {
  const LoadPage({super.key});

  @override
  State<LoadPage> createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<ChatViewModel>().init();
      await context.read<TrendViewModel>().init();
      await context.read<ImageViewModel>().init();
      await context.read<DictionaryViewModel>().init();
      await context.read<DebugViewModel>().init();
      await context.read<SettingViewModel>().init();
      MyRoute.off(context, '/chat');
    });
  }

  Widget _buildLoadWidget({required Widget background, required Widget title}) {
    return Stack(children: [
      background,
      Positioned(
          bottom: 70,
          child:
              SizedBox(width: MediaQuery.of(context).size.width, child: title))
    ]);
  }

  Widget _buildBackground() {
    debugPrint('构建加载背景');
    return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset('assets/photo/S1-01-n.webp', fit: BoxFit.cover));
  }

  Widget _buildTitle() {
    debugPrint('构建加载标题');
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset('assets/icon/异次元通讯.webp', height: 40),
      Image.asset('assets/icon/次元复苏.webp', height: 30)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return _buildLoadWidget(
        title: _buildTitle(), background: _buildBackground());
  }
}
