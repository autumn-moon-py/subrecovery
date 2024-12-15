import 'package:flutter/material.dart';

import '../../theme/color.dart';
import 'widget.dart';

class DictionaryPage extends StatelessWidget {
  const DictionaryPage({super.key});
  Widget _dictionaryWidget({required Widget body, required Widget background}) {
    return Stack(children: [background, body]);
  }

  Widget _buildBody() {
    return const DictionaryBody();
  }

  Widget _buildBackground() {
    return Container(color: MyTheme.background);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: const BackButton(color: Colors.white),
            title: Text('词典', style: MyTheme.bigStyle),
            backgroundColor: MyTheme.background51),
        body: _dictionaryWidget(
            body: _buildBody(), background: _buildBackground()));
  }
}
