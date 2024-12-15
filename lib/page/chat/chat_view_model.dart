// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../model/message_model.dart';
import '../../model/user_model.dart';
import '../../utils/app_utils.dart';
import 'controller.dart';

class ChatViewModel with ChangeNotifier {
  String _name = '';
  final List<Message> _message = [];
  final List<List> _story = [];
  bool _showChoose = false;
  String _leftChoose = '';
  int _leftJump = 0;
  int _rightJump = 0;
  String _rightChoose = '';
  bool _typing = false;
  int _startTime = 0;
  int _line = 0;
  int _beJump = 0;
  int _jump = 0;
  int _resetLine = 0;
  String _chapter = '第一章';
  String _avatarUrl = '';
  bool _isPaused = false;
  final user = User();
  final ScrollController chatController = ScrollController();

  Future<void> init() async {
    await user.load();
    _avatarUrl = user.avatar;
    _line = user.playLine;
    _name = user.name;
    _jump = user.jump;
    _resetLine = user.resetLine;
    _message.addAll(user.oldMessage);
    _chapter = user.chapter;
    _startTime = user.startTime;
    debugPrint('读取聊天历史');
  }

  void addOldChooseItem(int line) {
    if (oldChoose.length < 5) {
      user.oldChoose.add(line);
    }
    if (oldChoose.length == 5) {
      user.oldChoose.removeAt(0);
      user.oldChoose.add(line);
    }
    user.save();
  }

  List<int> get oldChoose => user.oldChoose;

  void changeIsPaused(bool value) {
    _isPaused = value;
    notifyListeners();
  }

  bool get isPaused => _isPaused;

  void changeAvatarUrl(String avatarUrl) {
    _avatarUrl = avatarUrl;
    user.avatar = _avatarUrl;
    user.save();
    notifyListeners();
  }

  String get avatarUrl => _avatarUrl;

  Future<void> changeChapter(String chapter, BuildContext context) async {
    _chapter = chapter;
    _message.clear();
    _story.clear();
    _leftChoose = '';
    _leftJump = 0;
    _rightChoose = '';
    _rightJump = 0;
    _jump = 0;
    _line = 0;
    _beJump = 0;
    _resetLine = 0;
    _showChoose = false;
    _startTime = 0;
    user.chapter = _chapter;
    user.save();
    await changeStory();
    notifyListeners();
    storyPlayer(context);
  }

  String get chapter => _chapter;

  void changeLeftJump(int jump) => _leftJump = jump;

  int get leftJump => _leftJump;

  void changeRightJump(int jump) {
    _rightJump = jump;
    _showChoose = true;
    changeShowChoose(showChoose);
  }

  int get rightJump => _rightJump;

  void changeResetLine(int resetLine) {
    _resetLine = resetLine;
    user.resetLine = _resetLine;
    user.save();
  }

  void changeChap(String chapter) => _chapter = chapter;

  int get resetLine => _resetLine;

  void changeJump(int jump) {
    _jump = jump;
    user.jump = _jump;
    user.save();
  }

  int get jump => _jump;

  void changeBeJump(int beJump) => _beJump = beJump;

  int get beJump => _beJump;

  void changeLine(int line) {
    user.playLine = line;
    _line = line;
    user.save();
  }

  int get line => _line;

  Future<void> changeStory() async {
    _story.clear();
    List<List> story0 = await Utils.loadCVS(chapter) as List<List>;
    _story.addAll(story0);
  }

  List<List> get story => _story;

  void changeName(String name) {
    _name = name;
    notifyListeners();
  }

  void addItem(Message item) {
    if (checkMessage(item)) return;
    _message.add(item);
    notifyListeners();
    user.playLine = _line;
    user.oldMessage = _message;
    user.name = _name;
    user.save();
    chatController.jumpTo(chatController.position.maxScrollExtent);
  }

  bool checkMessage(Message item) {
    if (_message.isEmpty) return false;
    if (_message.last.message == item.message) return true;
    return false;
  }

  void clearMessage() {
    _message.clear();
    debugPrint('清空聊天历史');
    notifyListeners();
  }

  void changeShowChoose(bool showChoose) {
    if (!showChoose) {
      _leftChoose = '';
      _rightChoose = '';
    }
    if (showChoose) {
      user.playLine = _line - 2;
      user.save();
    }
    _showChoose = showChoose;
    notifyListeners();
  }

  void changeLeftChoose(String leftChoose) {
    _leftChoose = leftChoose;
    notifyListeners();
  }

  void changeRightChoose(String rightChoose) {
    _rightChoose = rightChoose;
    notifyListeners();
  }

  void changeTyping(bool typing) {
    _typing = typing;
    notifyListeners();
  }

  void changeStartTime(int startTime) {
    _startTime = startTime;
    user.startTime = _startTime;
    user.save();
  }

  String get name => _name;
  List<Message> get message => _message;
  bool get showChoose => _showChoose;
  String get leftChoose => _leftChoose;
  String get rightChoose => _rightChoose;
  bool get typing => _typing;
  int get startTime => _startTime;
}
