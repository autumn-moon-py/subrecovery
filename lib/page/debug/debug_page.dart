import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../model/debug_model.dart';
import '../../theme/color.dart';
import '../../utils/app_utils.dart';
import '../chat/chat_view_model.dart';
import 'debug_view_model.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({super.key});

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  Widget _debugWidget(
      {required Widget body,
      required List<Widget> acitons,
      required Widget background}) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: MyTheme.foreground,
            actions: acitons,
            title: const Text('异常日志')),
        body: Stack(children: [background, body]));
  }

  Widget _buildBackground() {
    return Stack(children: [
      Container(color: MyTheme.background),
      const Center(
          child: Text('提示：单击日志列表可复制到粘贴板\r\n右上角手动添加记录',
              style: TextStyle(color: Colors.grey, fontSize: 20)))
    ]);
  }

  Widget _buildListItem(int index, DebugInfo debugInfo) {
    final line = debugInfo.line;
    final beJump = debugInfo.beJump;
    final jump = debugInfo.jump;
    final error = debugInfo.error;
    final version = debugInfo.version;
    final time = debugInfo.time;
    final chapter = debugInfo.chapter;
    final startTime =
        DateTime.fromMillisecondsSinceEpoch(debugInfo.startTime).toString();
    final maxWidth = MediaQuery.of(context).size.width - 50;
    const style = TextStyle(color: Colors.white, fontSize: 15);
    return GestureDetector(
        onTap: () => debugInfo.copy(),
        child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(children: [
              Text(index.toString(), style: style.copyWith(fontSize: 20)),
              const SizedBox(width: 10),
              ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Text(
                      '行: $line,章节：$chapter,分支: $beJump,跳转: $jump\r\n异常: $error\r\n版本: $version\r\n时间: $time\r\n等待时间: $startTime',
                      style: style))
            ])));
  }

  Widget _buildBody() {
    final debug = context.watch<DebugViewModel>().debugList;
    return ListView.builder(
        itemCount: debug.length,
        padding: const EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) => _buildListItem(index, debug[index]));
  }

  List<Widget> _buildActions() {
    final model = context.read<DebugViewModel>();
    final chatModel = context.read<ChatViewModel>();
    return [
      IconButton(
          onPressed: () async {
            try {
              DebugInfo debugInfo = DebugInfo();
              debugInfo.beJump = chatModel.beJump;
              debugInfo.error = '反馈时额外备注';
              debugInfo.jump = chatModel.jump;
              debugInfo.line = chatModel.line;
              debugInfo.time = DateTime.now().toString();
              debugInfo.version = await Utils.getVersion();
              debugInfo.chapter = chatModel.chapter;
              debugInfo.startTime = chatModel.startTime;
              model.addItem(debugInfo);
              EasyLoading.showToast('成功添加日志');
            } catch (e) {
              EasyLoading.showError('添加日志失败：$e');
            }
          },
          icon: const Icon(Icons.add)),
      IconButton(
          onPressed: () => model.cleanDebugList(),
          icon: const Icon(Icons.delete))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return _debugWidget(
        background: _buildBackground(),
        acitons: _buildActions(),
        body: _buildBody());
  }
}
