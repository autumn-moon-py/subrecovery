import 'package:flutter/material.dart';

import '../../theme/color.dart';
import 'widget.dart';

class TrendPage extends StatelessWidget {
  const TrendPage({super.key});

  Widget _trendWidget(
      {required Widget top,
      required Widget body,
      required Widget tip,
      required Widget background}) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: const BackButton(color: Colors.white),
            backgroundColor: MyTheme.background,
            title: const Text('动态')),
        body: Stack(children: [
          background,
          tip,
          ListView(
              physics: const BouncingScrollPhysics(), children: [top, body])
        ]));
  }

  Widget _buildBackground() {
    return Container(color: MyTheme.background51);
  }

  @override
  Widget build(BuildContext context) {
    return _trendWidget(
        top: const TrendTop(),
        body: const TrednBody(),
        tip: const TrendTip(),
        background: _buildBackground());
  }
}
