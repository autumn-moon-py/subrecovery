import 'package:flutter/material.dart';
import 'package:keframe/keframe.dart';
import 'package:provider/provider.dart';

import '../../model/dictionary_model.dart';
import '../../theme/color.dart';
import '../../utils/routes.dart';
import 'dictionary_view_model.dart';

class DictionaryBody extends StatefulWidget {
  const DictionaryBody({super.key});

  @override
  State<DictionaryBody> createState() => _DictionaryBodyState();
}

class _DictionaryBodyState extends State<DictionaryBody> {
  Widget _buildGrid(List<Dictionary> data) {
    return SizeCacheWidget(
        estimateCount: 115,
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 3.5),
            itemCount: data.length,
            itemBuilder: (context, index) => FrameSeparateWidget(
                index: index,
                placeHolder: const Icon(Icons.replay_circle_filled_rounded,
                    color: Colors.blue),
                child: _buildGridItem(data[index]))));
  }

  Widget _buildGridItem(Dictionary dic) {
    final width = MediaQuery.of(context).size.width / 2 - 30;

    return !dic.lock
        ? ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
                width: width,
                color: MyTheme.foreground62,
                child: const Icon(Icons.lock, color: Colors.grey)),
          )
        : GestureDetector(
            onTap: () => MyRoute.to(context, '/dic_view', dic),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                  width: width,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color.fromRGBO(44, 29, 84, 1),
                    Color.fromRGBO(46, 50, 162, 1)
                  ])),
                  child: Text(dic.name, style: MyTheme.narmalStyle)),
            ));
  }

  Widget _buildTitle(String chapter) {
    final width = MediaQuery.of(context).size.width;
    final style = MyTheme.bigStyle;
    Widget line = Container(color: Colors.grey, height: 2, width: 70);
    double top = chapter == '第一章' ? 0 : 20;
    return Container(
        margin: EdgeInsets.only(top: top, bottom: 10),
        width: width,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          line,
          const SizedBox(width: 10),
          Text(chapter, style: style),
          const SizedBox(width: 10),
          line
        ]));
  }

  Widget _buildChapterDic(String chapter, List<Dictionary> data) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [_buildTitle(chapter), _buildGrid(data)]);
  }

  Widget _buildAll() {
    final dictionaryModelList =
        context.watch<DictionaryViewModel>().dictionaryModelList;
    List<Dictionary> first = [];
    List<Dictionary> other1 = [];
    List<Dictionary> second = [];
    List<Dictionary> other2 = [];
    List<Dictionary> third = [];
    List<Dictionary> fourth = [];
    List<Dictionary> fifth = [];
    List<Dictionary> sixth = [];

    for (var item in dictionaryModelList) {
      final chapter = item.chapter;
      if (chapter == '第一章') first.add(item);
      if (chapter == '番外一') other1.add(item);
      if (chapter == '第二章') second.add(item);
      if (chapter == '番外二') other2.add(item);
      if (chapter == '第三章') third.add(item);
      if (chapter == '第四章') fourth.add(item);
      if (chapter == '第五章') fifth.add(item);
      if (chapter == '第六章') sixth.add(item);
    }

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          const SizedBox(height: 10),
          _buildChapterDic('第一章', first),
          _buildChapterDic('番外一', other1),
          _buildChapterDic('第二章', second),
          _buildChapterDic('番外二', other2),
          _buildChapterDic('第三章', third),
          _buildChapterDic('第四章', fourth),
          _buildChapterDic('第五章', fifth),
          _buildChapterDic('第六章', sixth),
          const SizedBox(height: 10)
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return _buildAll();
  }
}

class DictionaryView extends StatelessWidget {
  const DictionaryView({super.key});

  Widget _buildWidget({required Widget body, required Widget background}) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: MyTheme.foreground,
            title: Text('词典展示', style: MyTheme.bigStyle)),
        body: Stack(children: [background, body]));
  }

  Widget _buildBackground() {
    return Container(color: MyTheme.background);
  }

  Widget _buildBody(Dictionary dictionary) {
    return Stack(children: [
      Center(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/dictionary/词典展示.webp',
                  width: 300, fit: BoxFit.cover))),
      Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 220),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset('assets/dictionary/词典.webp', width: 60),
            const SizedBox(height: 10),
            Text(dictionary.name, style: MyTheme.bigStyle),
            const SizedBox(height: 10),
            Container(width: 250, height: 1, color: Colors.white),
            const SizedBox(height: 10),
            Container(
                padding: const EdgeInsets.only(left: 5),
                width: 290,
                child: Text(dictionary.mean, style: MyTheme.narmalStyle))
          ]))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Dictionary dictionary =
        ModalRoute.of(context)!.settings.arguments as Dictionary;
    return _buildWidget(
        body: _buildBody(dictionary), background: _buildBackground());
  }
}
