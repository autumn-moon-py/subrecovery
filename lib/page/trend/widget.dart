import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../theme/color.dart';
import '../../utils/routes.dart';
import '../../widget.dart';
import '../setting/setting_view_model.dart';
import '../../model/trend_model.dart';
import 'trend_view_model.dart';

class TrendTip extends StatefulWidget {
  const TrendTip({super.key});

  @override
  State<TrendTip> createState() => _TrendTipState();
}

class _TrendTipState extends State<TrendTip> {
  @override
  Widget build(BuildContext context) {
    final trends = context.watch<TrendViewModel>().trends;
    return Center(
        child: Text(trends.isEmpty ? '对方没有发布任何动态' : '',
            style: const TextStyle(color: Colors.white)));
  }
}

class TrendTop extends StatelessWidget {
  const TrendTop({super.key});

  Widget tag(String title) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
          padding: const EdgeInsets.all(7),
          color: Colors.black26,
          child: Text(title,
              style: const TextStyle(
                  color: Color.fromARGB(255, 190, 190, 190), fontSize: 15))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nowMikoAvatar = context.read<SettingViewModel>().nowMikoAvatar;

    return Stack(children: [
      cilpWidget(
          width: 1080,
          height: 520,
          yOffset: -1200,
          child: Blur(
              colorOpacity: 0.1,
              blur: 5,
              blurColor: Colors.transparent,
              child: Image.asset('assets/images/聊天背景.webp'))),
      Column(children: [
        const SizedBox(height: 5),
        SizedBox(
            height: 60,
            child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 40,
                child: Image.asset('assets/icon/头像$nowMikoAvatar.webp'))),
        const SizedBox(height: 5),
        const Text('Miko', style: TextStyle(color: Colors.white, fontSize: 20)),
        const SizedBox(height: 5),
        const Text('走在未知的道路上，不许停也不能回头',
            style: TextStyle(color: Colors.white, fontSize: 15)),
        const SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          tag('甜品控'),
          const SizedBox(width: 10),
          tag('高中生'),
          const SizedBox(width: 10),
          tag('蓝带'),
          const SizedBox(width: 10),
          tag('腿玩年')
        ])
      ])
    ]);
  }
}

class TrednBody extends StatefulWidget {
  const TrednBody({super.key});

  @override
  State<TrednBody> createState() => _TrednBodyState();
}

class _TrednBodyState extends State<TrednBody> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final trends = context.watch<TrendViewModel>().trends;
    return ListView.builder(
        controller: scrollController,
        shrinkWrap: true,
        reverse: true,
        padding: const EdgeInsets.only(left: 10, bottom: 20),
        physics: const BouncingScrollPhysics(),
        itemCount: trends.length,
        itemBuilder: (_, int index) => TrendItem(trends[index]));
  }
}

class TrendItem extends StatelessWidget {
  final Trend trend;
  const TrendItem(this.trend, {super.key});

  @override
  Widget build(BuildContext context) {
    final nowMikoAvatar = context.read<SettingViewModel>().nowMikoAvatar;
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.asset('assets/icon/头像$nowMikoAvatar.webp', height: 40),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('Miko',
                    style:
                        MyTheme.narmalStyle.copyWith(color: Colors.blueGrey)),
                const SizedBox(height: 5),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 0.8.sw),
                  child: Text(trend.trend,
                      softWrap: true,
                      textAlign: TextAlign.left,
                      style: MyTheme.narmalStyle),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                    onTap: () =>
                        MyRoute.to(context, '/image_view', trend.image),
                    child: Image.asset('assets/photo/${trend.image}.webp',
                        width: 150, fit: BoxFit.cover)),
                const SizedBox(height: 5),
                Text(
                    "${trend.time.month}月${trend.time.day}日 ${trend.time.hour}:${trend.time.minute}",
                    style: const TextStyle(fontSize: 13, color: Colors.grey))
              ]))
        ]));
  }
}
