import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../theme/color.dart';
import '../../utils/app_utils.dart';
import '../../widget.dart';
import '../dictionary/dictionary_view_model.dart';
import '../image/image_view_model.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String version = '';
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    version = await Utils.getVersion();
    setState(() {});
  }

  Widget _aboutWidget({required Widget body, required Widget background}) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: const BackButton(color: Colors.white),
            backgroundColor: MyTheme.foreground,
            title: GestureDetector(
                onDoubleTap: () {
                  // caidna();
                },
                child: Text('关于异次元通讯-次元复苏', style: MyTheme.bigStyle))),
        body: Stack(children: [background, body]));
  }

  Widget _buildBackground() {
    return Container(color: MyTheme.background);
  }

  void caidna() {
    context.read<ImageViewModel>().lockAllImage();
    context.read<DictionaryViewModel>().lockAllDic();
    EasyLoading.showSuccess('你已触发彩蛋, 本次启动解锁全部词典和图鉴，下次进入重置为原解锁进度');
  }

  Widget _buildBody() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Column(children: [
          const SizedBox(height: 10),
          GestureDetector(
            onDoubleTap: () {
              // caidna();
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('assets/icon/icon.webp', width: 70)),
          ),
          const SizedBox(height: 5),
          GestureDetector(
              onDoubleTap: () {
                caidna();
              },
              child: Text(version,
                  style: MyTheme.bigStyle.copyWith(color: Colors.grey))),
          const SizedBox(height: 5),
          const SizedBox(height: 10),
          buildCard(children: [
            buildDefaultItem(
                leading: Icons.my_library_books_sharp,
                title: '官网',
                onTap: () => Utils.openWebSite('https://www.subrecovery.top')),
            buildDefaultItem(
                leading: Icons.my_library_books_sharp,
                title: 'TapTap',
                onTap: () =>
                    Utils.openWebSite('https://www.taptap.cn/app/378027')),
            buildDefaultItem(
                leading: Icons.my_library_books_sharp,
                title: '好游快爆',
                onTap: () =>
                    Utils.openWebSite('https://www.3839.com/a/156008.htm')),
            buildDefaultItem(
                leading: Icons.group,
                title: 'Q群',
                onTap: () => Utils.openWebSite(
                    'http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=-pPGHln9yKNzS00OdFJRxZ69Q-rEX_nx&authKey=kLPWmtcFJCAPpgv18epf4MW9SxGPVGTqPKKWtbOt1C%2FTX%2ByIOEyjpYeMSGxe9KWZ&noverify=0&group_code=465805687'))
          ])
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return _aboutWidget(background: _buildBackground(), body: _buildBody());
  }
}
