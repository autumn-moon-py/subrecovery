import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:keframe/keframe.dart';
import 'package:provider/provider.dart';

import '../../theme/color.dart';
import '../../utils/app_utils.dart';
import '../../utils/routes.dart';
import 'image_view_model.dart';

class ImageBody extends StatefulWidget {
  const ImageBody({super.key});

  @override
  State<ImageBody> createState() => _ImageBodyState();
}

class _ImageBodyState extends State<ImageBody> {
  Widget _buildGrid(List<String> data) {
    return SizeCacheWidget(
        estimateCount: 55,
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 3, crossAxisSpacing: 3),
            itemCount: data.length,
            itemBuilder: (context, index) => FrameSeparateWidget(
                index: index,
                placeHolder: const Icon(Icons.replay_circle_filled_rounded,
                    color: Colors.blue),
                child: _buildGridItem(data[index]))));
  }

  Widget _buildGridItem(String image) {
    final imageMap = context.read<ImageViewModel>().imageMap;
    bool lock = imageMap[image];
    final width = MediaQuery.of(context).size.width / 3;

    Widget imageName() {
      return Positioned(
          left: 10,
          bottom: 5,
          child: Text(image,
              style: MyTheme.narmalStyle
                  .copyWith(color: lock ? Colors.white : Colors.grey)));
    }

    return !lock
        ? SizedBox(
            width: width,
            height: width,
            child: Stack(children: [
              Blur(
                  blur: 5,
                  colorOpacity: 0.1,
                  blurColor: Colors.transparent,
                  child: Container(
                      width: width,
                      height: width,
                      color: MyTheme.foreground62)),
              const Center(child: Icon(Icons.lock, color: Colors.grey)),
              imageName()
            ]))
        : GestureDetector(
            onTap: () {
              MyRoute.to(context, '/image_view', image);
            },
            child: Stack(children: [
              Image.asset('assets/photo/$image.webp',
                  width: width, height: width, fit: BoxFit.cover),
              imageName()
            ]));
  }

  Widget _buildTitle(String chapter, int length, int lock) {
    final style = MyTheme.bigStyle;
    return Container(
        margin: const EdgeInsets.fromLTRB(20, 20, 0, 10),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.ideographic,
            children: [
              Text(chapter, style: style),
              const SizedBox(width: 10),
              Text('$lock/$length', style: MyTheme.narmalStyle)
            ]));
  }

  Widget _buildChapterImage(String chapter, List<String> data) {
    int lock = 0;
    final imageMap = context.watch<ImageViewModel>().imageMap;
    for (var item in data) {
      bool lock0 = imageMap[item];
      if (lock0) lock++;
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [_buildTitle(chapter, data.length, lock), _buildGrid(data)]);
  }

  Widget _buildAll() {
    List<String> data = [];
    final imageList = context.read<ImageViewModel>().imageList;
    data = imageList;
    List<String> first = [];
    List<String> other1 = [];
    List<String> second = [];
    List<String> other2 = [];
    List<String> third = [];
    List<String> fourth = [];
    List<String> fifth = [];
    List<String> sixth = [];
    List<String> other4 = [];

    for (var item in data) {
      if (item.contains('S1')) {
        first.add(item);
      }
      if (item.contains('E1')) {
        other1.add(item);
      }
      if (item.contains('S2')) {
        second.add(item);
      }
      if (item.contains('E2')) {
        other2.add(item);
      }
      if (item.contains('S3')) {
        third.add(item);
      }
      if (item.contains('S4')) {
        fourth.add(item);
      }
      if (item.contains('S5')) {
        fifth.add(item);
      }
      if (item.contains('S6')) {
        sixth.add(item);
      }
      if (item.contains('W1')) {
        other4.add(item);
      }
    }

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          _buildChapterImage('第一章', first),
          _buildChapterImage('番外一', other1),
          _buildChapterImage('第二章', second),
          _buildChapterImage('番外二', other2),
          _buildChapterImage('第三章', third),
          _buildChapterImage('第四章', fourth),
          _buildChapterImage('第五章', fifth),
          _buildChapterImage('第六章', sixth),
          _buildChapterImage('微博', other4),
          const SizedBox(height: 10)
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return _buildAll();
  }
}

class ImageView extends StatelessWidget {
  const ImageView({super.key});

  @override
  Widget build(BuildContext context) {
    String imageName = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: MyTheme.foreground,
            centerTitle: true,
            toolbarHeight: 40,
            title: Text(imageName, style: MyTheme.bigStyle),
            actions: [
              IconButton(
                  onPressed: () => Utils.downloadImage(imageName),
                  icon: const Icon(Icons.download, color: Colors.white))
            ]),
        body: Stack(children: [
          Container(color: MyTheme.background),
          Center(
              child: InteractiveViewer(
                  child: Image.asset('assets/photo/$imageName.webp',
                      width: double.infinity, fit: BoxFit.fitWidth)))
        ]));
  }
}
