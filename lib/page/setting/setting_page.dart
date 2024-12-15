import 'package:flutter/material.dart';

import '../../theme/color.dart';
import 'widget.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Widget _settingWidget({required Widget backgroud, required Widget body}) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const BackButton(color: Colors.white),
          title: Text('设置', style: MyTheme.bigStyle),
          backgroundColor: MyTheme.foreground,
        ),
        body: Stack(children: [backgroud, body]));
  }

  Widget _buildBackgroun() {
    return Container(color: MyTheme.background);
  }

  Widget _buildBody() {
    return const SettingBody();
  }

  @override
  Widget build(BuildContext context) {
    return _settingWidget(backgroud: _buildBackgroun(), body: _buildBody());
  }
}
