import 'package:blur/blur.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../theme/color.dart';
import '../../utils/app_utils.dart';
import '../../utils/dialog_utils.dart';
// import '../../utils/notification.dart';
import '../../utils/routes.dart';
import '../../widget.dart';
import '../setting/setting_view_model.dart';
import 'chat_view_model.dart';
import 'controller.dart';
import 'widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Utils.init(context);
      DialogUtils.init(context);
      if (kDebugMode) {
        // ignore: unused_local_variable
        final chatModel = context.read<ChatViewModel>();
        // chatModel.clearMessage();
        // chatModel.changeLine(1621);
        // chatModel.changeStartTime(0);
        // chatModel.changeBeJump(104);
        // chatModel.changeJump(0);
        // chatModel.changeResetLine(1621);
        // chatModel.changeChap('第一章');
      }
      storyPlayer(context);
      // await Jpush.setup();
      debugPrint('聊天初始化');
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    bgmPlayer.dispose();
    buttonPlayer.dispose();
    voicePlayer.dispose();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    final chatModel = context.read<ChatViewModel>();
    final playBgm = context.read<SettingViewModel>().bgm;
    switch (state) {
      case AppLifecycleState.resumed:
        chatModel.changeIsPaused(false);
        if (playBgm && !bgmPlayer.playing) bgmPlayer.play();
        setState(() {});
        debugPrint("应用进入前台======");
        break;
      case AppLifecycleState.inactive:
        debugPrint("应用处于闲置状态，这种状态的应用应该假设他们可能在任何时候暂停 切换到后台会触发======");
        break;
      case AppLifecycleState.detached:
        debugPrint("当前页面即将退出======");
        break;
      case AppLifecycleState.paused:
        chatModel.changeIsPaused(true);
        if (bgmPlayer.playing) bgmPlayer.pause();
        debugPrint("应用处于不可见状态 后台======");
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  Widget _buildTitle() {
    return const TitleWidget();
  }

  Widget _buildBody() {
    return const ChatList();
  }

  Widget _buildChooseButton() {
    return const ChooseButton();
  }

  Widget _buildBackground() {
    return Blur(
        blurColor: Colors.transparent,
        blur: 1.5,
        colorOpacity: 0.2,
        child: Image.asset('assets/images/聊天背景.webp',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover));
  }

  Widget _buildSettingButton() {
    return IconButton(
        onPressed: () {
          MyRoute.to(context, '/setting');
        },
        icon: Icon(Icons.settings,
            color: Colors.white, size: MyTheme.narmalIconSize));
  }

  Widget _buildDrawer() {
    Widget item(
        {required IconData leading,
        required String title,
        required Function onTap}) {
      return Builder(builder: (context) {
        return GestureDetector(
            onTap: () {
              Scaffold.of(context).closeDrawer();
              onTap.call();
            },
            child: ListTile(
                leading: Icon(leading,
                    color: Colors.grey, size: MyTheme.bigIconSize),
                title: Text(title, style: MyTheme.bigStyle),
                trailing: const Icon(Icons.arrow_forward_ios,
                    color: Colors.grey, size: 20)));
      });
    }

    return Stack(children: [
      cilpWidget(
          width: 1080,
          height: 500,
          yOffset: -1200,
          child: Image.asset('assets/images/聊天背景.webp')),
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        item(
            leading: Icons.photo,
            title: '图鉴',
            onTap: () => MyRoute.to(context, '/image')),
        item(
            leading: Icons.type_specimen,
            title: '词典',
            onTap: () => MyRoute.to(context, '/dic')),
        item(
            leading: Icons.menu_book_rounded,
            title: '章节',
            onTap: () => MyRoute.to(context, '/chapter')),
        item(
            leading: Icons.info_outline_rounded,
            title: '关于',
            onTap: () => MyRoute.to(context, '/about'))
      ])
    ]);
  }

  Widget _buildJumpDayButton() {
    return IconButton(
        onPressed: () {
          jumpDayDialog(context);
        },
        icon: Icon(Icons.date_range,
            color: Colors.white, size: MyTheme.narmalIconSize));
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('构建页面');
    return HomeWidget(
        leadingIcon: Icons.menu,
        appbarColor: MyTheme.foreground,
        leadingIconSize: MyTheme.narmalIconSize,
        drawer: _buildDrawer(),
        title: _buildTitle(),
        actions: [
          _buildJumpDayButton(),
          SizedBox(width: 10.w),
          _buildSettingButton(),
          SizedBox(width: 10.w)
        ],
        body: _buildBody(),
        toLast: const ToLast(),
        background: _buildBackground(),
        bottom: _buildChooseButton());
  }
}
