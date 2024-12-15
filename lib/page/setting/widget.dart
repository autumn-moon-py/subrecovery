import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../theme/color.dart';
import '../../utils/app_utils.dart';
import '../../utils/routes.dart';
import '../../widget.dart';
import '../chat/chat_view_model.dart';
import 'setting_view_model.dart';

class SettingBody extends StatefulWidget {
  const SettingBody({super.key});

  @override
  State<SettingBody> createState() => _SettingBodyState();
}

class _SettingBodyState extends State<SettingBody> {
  Widget _buildBody({required List<Widget> children}) {
    return ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        children: children);
  }

  // ignore: unused_element
  Widget _buildDebugButton() {
    return buildCard(children: [
      buildDefaultItem(
          leading: Icons.error,
          title: '异常日志',
          onTap: () => MyRoute.to(context, '/debug')),
      buildDefaultItem(
          leading: Icons.list_alt,
          title: '异常反馈',
          onTap: () {
            Utils.openWebSite(
                'https://docs.qq.com/form/page/DVVZJa1hQY3BtZnlw');
          })
    ]);
  }

  Widget _buildMusicButton() {
    final model = context.read<SettingViewModel>();
    final bgm = context.watch<SettingViewModel>().bgm;
    final buttonMusic = context.watch<SettingViewModel>().buttonMusic;
    final oldBgm = context.watch<SettingViewModel>().oldBgm;
    final voice = context.watch<SettingViewModel>().voice;
    return buildCard(children: [
      buildDefaultItem(
          leading: Icons.music_note,
          title: '背景音乐',
          button: Switch(
              value: bgm,
              onChanged: (value) {
                model.changeBgm(value);
              })),
      buildDefaultItem(
          leading: Icons.music_note,
          title: '旧版音乐',
          button: Switch(
              value: oldBgm,
              onChanged: (value) {
                model.changeOldBgm(value);
              })),
      buildDefaultItem(
          leading: Icons.music_note_outlined,
          title: '按钮音效',
          button: Switch(
              value: buttonMusic,
              onChanged: (value) {
                model.changeButtonMusic(value);
              })),
      buildDefaultItem(
          leading: Icons.voice_chat,
          title: '语音开关',
          button: Switch(
              value: voice,
              onChanged: (value) {
                model.changeVoice(value);
                shuffixVoice(value);
              })),
    ]);
  }

  void shuffixVoice(bool voice) {
    if (!voice) {
      if (voicePlayer.playing) voicePlayer.pause();
      return;
    }
    final random = Random();
    double probability = 0.3;
    if (random.nextDouble() < probability) {
      final randomVoice = random.nextInt(2);
      if (randomVoice == 0) {
        voicePlayer.setAsset('assets/music/听得见吗.ogg');
      }
      if (randomVoice == 1) {
        voicePlayer.setAsset('assets/music/喂.ogg');
      }
      if (randomVoice == 2) {
        voicePlayer.setAsset('assets/music/我在哦.ogg');
      }
      voicePlayer.setVolume(0.5);
      if (!voicePlayer.playing) voicePlayer.play();
    }
  }

  Widget _buildChatButton() {
    final model = context.read<SettingViewModel>();
    final waitTyping = context.watch<SettingViewModel>().waitTyping;
    final waitOffline = context.watch<SettingViewModel>().waitOffline;
    final beLater = context.watch<SettingViewModel>().belater;
    final autoUnLock = context.watch<SettingViewModel>().autoUnLock;
    final tips = [
      "开：对方发消息会模拟打字等待一段时间\n关：不模拟打字时间直接发送",
      "开：在系统提示对方已下线时需要等待随机时间\n关：对方下线后立刻上线回复",
      "BE：Bed Ending（坏结局）\n开：进入BE后会自动跳出继续后续剧情\n关：进入BE后需要重开当天剧本",
      "开：到达章节末尾自动解锁本章节未解锁图鉴和词典"
    ];
    void showTip(int index) =>
        EasyLoading.showInfo(tips[index], duration: const Duration(seconds: 5));
    return buildCard(children: [
      buildDefaultItem(
          leading: Icons.keyboard,
          title: '打字时间',
          onTap: () => showTip(0),
          button: Switch(
              value: waitTyping,
              onChanged: (value) {
                model.changeWaitTyping(value);
              })),
      buildDefaultItem(
          leading: Icons.timelapse,
          title: '下线时间',
          onTap: () => showTip(1),
          button: Switch(
              value: waitOffline,
              onChanged: (value) {
                model.changeWaitOffline(value);
              })),
      buildDefaultItem(
          leading: Icons.storage,
          title: 'BE自动跳出',
          onTap: () => showTip(2),
          button: Switch(
              value: beLater,
              onChanged: (value) {
                model.changeBeLater(value);
              })),
      buildDefaultItem(
          leading: Icons.lock,
          title: '自动解锁',
          onTap: () => showTip(3),
          button: Switch(
              value: autoUnLock,
              onChanged: (value) {
                model.changeAutoUnlock(value);
              }))
    ]);
  }

  Widget _buildAvatarButton() {
    final model = context.read<SettingViewModel>();
    final nowMikoAvatar = context.watch<SettingViewModel>().nowMikoAvatar;
    final userModel = context.watch<ChatViewModel>();
    final playAvatar = userModel.avatarUrl;
    return buildCard(children: [
      buildDefaultItem(
          leading: Icons.person_2,
          title: 'Miko头像',
          button: DropdownButton(
              value: nowMikoAvatar,
              iconEnabledColor: Colors.white,
              underline: const Divider(),
              style: const TextStyle(color: Colors.white, fontSize: 25),
              dropdownColor: MyTheme.foreground62,
              items: List.generate(
                  8,
                  (index) => DropdownMenuItem(
                      value: index + 1,
                      alignment: Alignment.center,
                      child: Image.asset('assets/icon/头像${index + 1}.webp',
                          width: 35))),
              onChanged: (value) {
                model.changeNowMikoAvatar(value ?? 1);
              })),
      buildDefaultItem(
          leading: Icons.person,
          title: '玩家头像',
          subTitle: "点击设置玩家头像",
          onTap: () {
            String avatarUrl = '';
            Get.dialog(AlertDialog(
                backgroundColor: MyTheme.foreground62,
                title:
                    const Text('请输入QQ号', style: TextStyle(color: Colors.white)),
                content: TextField(
                    style: MyTheme.narmalStyle,
                    onChanged: (value) {
                      avatarUrl = 'http://q1.qlogo.cn/g?b=qq&nk=$value&s=100';
                    }),
                actions: [
                  TextButton(
                      onPressed: () {
                        userModel.changeAvatarUrl('');
                        Get.back();
                      },
                      child: const Text('清除')),
                  TextButton(
                      onPressed: () async {
                        Get.back();
                        if (avatarUrl.isEmpty) return;
                        userModel.changeAvatarUrl(avatarUrl);
                      },
                      child: const Text('确定'))
                ]));
          },
          button: playAvatar.isEmpty
              ? Image.asset('assets/icon/未知用户.webp', width: 40)
              : ClipOval(
                  child: Image.network(playAvatar, width: 35,
                      errorBuilder: (context, error, stackTrace) {
                  EasyLoading.showError('设置头像失败: $error');
                  return Image.asset('assets/icon/未知用户.webp', width: 40);
                })))
    ]);
  }

  Widget _buildTips() {
    return DefaultTextStyle(
        style: MyTheme.miniStyle.copyWith(color: Colors.yellow),
        child: buildCard(padding: true, addLine: false, children: [
          const Text('如有其它问题请前往Q群询问'),
          const Text('下方按钮点击中间会弹出提示'),
          const Text('miko错字是人设')
        ]));
  }

  @override
  Widget build(BuildContext context) {
    Widget padding = const SizedBox(height: 15);
    return _buildBody(children: [
      _buildTips(),
      padding,
      _buildChatButton(),
      // padding,
      // _buildDebugButton(),
      padding,
      _buildAvatarButton(),
      padding,
      _buildMusicButton()
    ]);
  }
}
