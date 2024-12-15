import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DebugInfo {
  int line = 0;
  int beJump = 0;
  int jump = 0;
  String error = '';
  String version = '';
  String time = '';
  String chapter = '';
  int startTime = 0;

  @override
  String toString() {
    return jsonEncode({
      'line': line,
      'beJump': beJump,
      'jump': jump,
      'error': error,
      'version': version,
      'time': time,
      'chapter': chapter,
      'startTime': startTime
    });
  }

  DebugInfo fromString(String json) {
    final debugInfoList = jsonDecode(json);
    DebugInfo debug = DebugInfo();
    debug.line = debugInfoList['line'];
    debug.beJump = debugInfoList['beJump'];
    debug.jump = debugInfoList['jump'];
    debug.error = debugInfoList['error'];
    debug.version = debugInfoList['version'];
    debug.time = debugInfoList['time'];
    debug.chapter = debugInfoList['chapter'];
    debug.startTime = debugInfoList['startTime'];
    return debug;
  }

  void copy() {
    final startTimeString =
        DateTime.fromMillisecondsSinceEpoch(startTime).toString();
    final debug =
        '行: $line,章节：$chapter,分支: $beJump,跳转: $jump\r\n异常: $error\r\n版本: $version\r\n时间: $time\r\n等待时间: $startTimeString';
    Clipboard.setData(ClipboardData(text: debug));
    EasyLoading.showToast('复制成功');
  }
}

class Debug {
  late SharedPreferences prefs;
  final List<DebugInfo> debugList = [];
  Future<void> save() async {
    prefs = await SharedPreferences.getInstance();
    List<String> debugStringList = [];
    for (var item in debugList) {
      debugStringList.add(item.toString());
    }
    prefs.setStringList('debugList', debugStringList);
  }

  Future<void> load() async {
    prefs = await SharedPreferences.getInstance();
    List<String> debugStringList = prefs.getStringList('debugList') ?? [];
    if (debugStringList.isNotEmpty) {
      for (var item in debugStringList) {
        DebugInfo debug = DebugInfo().fromString(item);
        debugList.add(debug);
      }
    }
  }
}
