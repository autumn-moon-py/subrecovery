// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../page/chat/widget.dart';
import '../page/dictionary/dictionary_view_model.dart';
import '../page/setting/setting_view_model.dart';
import '../utils/app_utils.dart';
import '../utils/routes.dart';
import 'dictionary_model.dart';

class Message {
  String name = '';
  String message = '';
  MessageType type = MessageType.left;
  late String image;
  late String avatarUrl;

  Message(this.name, this.message, this.type,
      {this.image = '', this.avatarUrl = ''});

  void avatarCallback(BuildContext context) {
    if (type == MessageType.left) {
      if (name == '未知用户') {
        EasyLoading.showToast('暂未解锁');
        return;
      }
      MyRoute.to(context, '/trend');
    }
  }

  void textCallback(BuildContext context, String dic) {
    final model = context.read<DictionaryViewModel>().dictionaryModelList;
    late Dictionary dictionary;
    for (var item in model) {
      if (item.name == dic) {
        dictionary = item;
        break;
      }
    }
    MyRoute.to(context, '/dic_view', dictionary);
  }

  void voiceCallback(BuildContext context, String msg) {
    final voice = context.read<SettingViewModel>().voice;
    voicePlayer.setAsset('assets/music/$msg.ogg');
    voicePlayer.setVolume(0.5);
    if (voicePlayer.playing) voicePlayer.pause();
    if (!voicePlayer.playing && voice) voicePlayer.play();
    if (!voice) EasyLoading.showToast('语音已关闭');
  }

  @override
  String toString() {
    Map messageMap = {
      'name': name,
      'message': message,
      'type': type.index,
      'image': image,
      'avatarUrl': avatarUrl
    };
    String json = jsonEncode(messageMap);
    return json;
  }

  void fromString(String json) {
    Map messageMap = jsonDecode(json);
    name = messageMap['name'];
    message = messageMap['message'];
    type = MessageType.values[messageMap['type']];
    image = messageMap['image'];
    avatarUrl = messageMap['avatarUrl'];
  }
}
