import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

import '../../theme/color.dart';
import '../../utils/routes.dart';
import '../chat/chat_view_model.dart';

const chapterList = ['第一章', '番外一', '第二章', '番外二', '第三章', '第四章', '第五章', '第六章'];

class ChapterPage extends StatelessWidget {
  const ChapterPage({super.key});

  void _changeChapter(String chapterName, BuildContext context) {
    final model = context.read<ChatViewModel>();
    final nowChapter = model.chapter;
    if (chapterName == nowChapter) {
      MyRoute.back(context);
    } else {
      Get.dialog(AlertDialog(
          backgroundColor: MyTheme.foreground62,
          title: const Center(
              child: Text('提示',
                  style: TextStyle(fontSize: 25, color: Colors.red))),
          content: const Text('此操作会清除当前游玩进度',
              style: TextStyle(fontSize: 20, color: Colors.white)),
          actions: [
            TextButton(
                child: const Text("取消",
                    style: TextStyle(color: Colors.grey, fontSize: 20)),
                onPressed: () {
                  Get.back();
                }),
            TextButton(
                child: const Text("确定",
                    style: TextStyle(color: Colors.lightBlue, fontSize: 20)),
                onPressed: () {
                  model.changeChapter(chapterName, context);
                  Get.back();
                  Get.back();
                })
          ]));
    }
  }

  Widget _buildChapterItem(String chapterName) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Builder(builder: (context) {
          return GestureDetector(
              onTap: () {
                _changeChapter(chapterName, context);
              },
              child: Image.asset('assets/chapter/$chapterName.webp',
                  width: 1.sw, fit: BoxFit.fitWidth));
        }));
  }

  Widget _chapterWidget({required Widget body, required Widget background}) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: const BackButton(color: Colors.white),
            title: const Text('章节'),
            backgroundColor: MyTheme.foreground62),
        body: Stack(children: [background, body]));
  }

  Widget _buildBody() {
    return ListView.builder(
        itemCount: chapterList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) {
          return _buildChapterItem(chapterList[index]);
        });
  }

  Widget _buildBackground() {
    return Container(color: MyTheme.background);
  }

  @override
  Widget build(BuildContext context) {
    return _chapterWidget(body: _buildBody(), background: _buildBackground());
  }
}
