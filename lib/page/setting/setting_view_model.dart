import 'package:flutter/material.dart';

import '../../model/setting_model.dart';
import '../../utils/app_utils.dart';

class SettingViewModel with ChangeNotifier {
  final Setting _setting = Setting();

  bool get belater => _setting.beLater;

  Future<void> init() async {
    await _setting.load();
  }

  void changeBeLater(bool value) {
    _setting.beLater = value;
    notifyListeners();
    _setting.save();
  }

  void changeOldBgm(bool value) {
    _setting.oldBgm = value;
    notifyListeners();
    _setting.save();
    if (value) {
      bgmPlayer.setAsset('assets/music/oldBgm.ogg');
    } else {
      bgmPlayer.setAsset('assets/music/bgm.ogg');
    }
    if (_setting.bgm) bgmPlayer.play();
  }

  void changeNowMikoAvatar(int nowMikoAvatar) {
    _setting.nowMikoAvatar = nowMikoAvatar;
    notifyListeners();
    _setting.save();
  }

  void changeBgm(bool value) {
    _setting.bgm = value;
    notifyListeners();
    _setting.save();
    if (!value) {
      bgmPlayer.pause();
    } else {
      bgmPlayer.play();
    }
  }

  void changeButtonMusic(bool value) {
    _setting.buttonMusic = value;
    notifyListeners();
    _setting.save();
  }

  void changeNewImage(bool value, BuildContext context) {
    _setting.newImage = value;
    notifyListeners();
    _setting.save();
  }

  void changeWaitTyping(bool value) {
    _setting.waitTyping = value;
    notifyListeners();
    _setting.save();
  }

  void changeWaitOffline(bool value) {
    _setting.waitOffline = value;
    notifyListeners();
    _setting.save();
  }

  void changeBubbleAnimation(bool value) {
    _setting.bubbleAnimation = value;
    notifyListeners();
    _setting.save();
  }

  void changePrivacy(bool value) {
    _setting.privacy = value;
    notifyListeners();
    _setting.save();
  }

  void changeBirthday(bool value) {
    _setting.birthday = value;
    _setting.save();
  }

  void changeApril(bool value) {
    _setting.april = value;
    _setting.save();
  }

  void changeChristmas(bool value) {
    _setting.christmas = value;
    _setting.save();
  }

  void changeVoice(bool value) {
    _setting.voice = value;
    notifyListeners();
    _setting.save();
  }

  void changeMidAutumn(bool value) {
    _setting.midAutumn = value;
    _setting.save();
  }

  void changeAutoUnlock(bool value) {
    _setting.autoUnLock = value;
    _setting.save();
  }

  int get nowMikoAvatar => _setting.nowMikoAvatar;
  bool get bgm => _setting.bgm;
  bool get buttonMusic => _setting.buttonMusic;
  bool get newImage => _setting.newImage;
  bool get waitTyping => _setting.waitTyping;
  bool get waitOffline => _setting.waitOffline;
  bool get bubbleAnimation => _setting.bubbleAnimation;
  bool get privacy => _setting.privacy;
  bool get birthday => _setting.birthday;
  bool get april => _setting.april;
  bool get oldBgm => _setting.oldBgm;
  bool get voice => _setting.voice;
  bool get midAutumn => _setting.midAutumn;
  bool get christmas => _setting.christmas;
  bool get autoUnLock => _setting.autoUnLock;
}
