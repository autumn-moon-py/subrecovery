import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../page/chat/widget.dart';
import 'message_model.dart';
import 'trend_model.dart';

class User {
  String avatar = '';
  String name = '';
  String chapter = '第一章';
  int playLine = 0;
  List<Message> oldMessage = [];
  List<Trend> oldTrend = [];
  List<int> oldChoose = [];
  int startTime = 0;
  int resetLine = 0;
  int jump = 0;
  late SharedPreferences prefs;

  Future<bool> firstRun() async {
    prefs = await SharedPreferences.getInstance();
    bool first = prefs.containsKey('avatar');
    return !first;
  }

  Future<void> load() async {
    prefs = await SharedPreferences.getInstance();
    avatar = prefs.getString('avatar') ?? avatar;
    name = prefs.getString('name') ?? name;
    playLine = prefs.getInt('playLine') ?? playLine;
    chapter = prefs.getString('chapter') ?? chapter;
    loadMessage(prefs.getStringList('oldMessage') ?? []);
    loadOldChoose(prefs.getStringList('oldChoose') ?? []);
    startTime = prefs.getInt('startTime') ?? startTime;
    resetLine = prefs.getInt('resetLine') ?? resetLine;
    jump = prefs.getInt('jump') ?? jump;
  }

  Future<void> loadTrend() async {
    prefs = await SharedPreferences.getInstance();
    List<String> trendList = prefs.getStringList('oldTrend') ?? [];
    if (trendList.isNotEmpty) loadTrendList(trendList);
  }

  Future<Map> loadImage(Map imageMap) async {
    prefs = await SharedPreferences.getInstance();
    final result = prefs.getString('imageMap') ?? '';
    if (result.isEmpty) return imageMap;
    Map imgMap = jsonDecode(result);
    return imgMap;
  }

  Future<Map> loadDic(Map dictionaryMap) async {
    prefs = await SharedPreferences.getInstance();
    final dicList = prefs.getStringList('dictionaryMap') ?? [];
    for (var item in dicList) {
      try {
        List dic = item.split(':');
        dictionaryMap[dic[0]][1] = dic[1];
      } catch (_) {
        continue;
      }
    }
    return dictionaryMap;
  }

  Future<void> save() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('avatar', avatar);
    prefs.setString('name', name);
    prefs.setString('chapter', chapter);
    prefs.setInt('playLine', playLine);
    prefs.setStringList('oldMessage', saveMessage());
    prefs.setStringList('oldChoose', saveOldChoose());
    prefs.setInt('startTime', startTime);
    prefs.setInt('resetLine', resetLine);
    prefs.setInt('jump', jump);
  }

  List<String> saveOldChoose() {
    List<String> oldChooseList = [];
    for (var choose in oldChoose) {
      oldChooseList.add(choose.toString());
    }
    return oldChooseList;
  }

  void loadOldChoose(List<String> list) {
    if (list.isEmpty) return;
    for (var item in list) {
      oldChoose.add(int.parse(item));
    }
  }

  Future<void> saveTrend() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setStringList('oldTrend', saveTrendList());
  }

  Future<void> saveImage(Map imageMap) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('imageMap', jsonEncode(imageMap));
  }

  Future<void> saveDic(Map dictionaryMap) async {
    prefs = await SharedPreferences.getInstance();
    List<String> dictionaryList = [];
    dictionaryMap.forEach((key, value) {
      dictionaryList.add('$key:${value[1]}');
    });
    prefs.setStringList('dictionaryMap', dictionaryList);
  }

  List<String> saveMessage() {
    List<String> messageList = [];
    for (var message in oldMessage) {
      messageList.add(message.toString());
    }
    return messageList;
  }

  void loadMessage(List<String> messageList) {
    if (messageList.isEmpty) return;
    for (var json in messageList) {
      Message message = Message('', '', MessageType.left);
      message.fromString(json);
      oldMessage.add(message);
    }
  }

  List<String> saveTrendList() {
    List<String> trendList = [];
    for (var trend in oldTrend) {
      trendList.add(trend.toString());
    }
    return trendList;
  }

  void loadTrendList(List<String> trendList) {
    for (var json in trendList) {
      Trend trend = Trend('', '', DateTime.now());
      trend.fromString(json);
      oldTrend.add(trend);
    }
  }
}
