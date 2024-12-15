import 'package:flutter/material.dart';

import '../../theme/color.dart';
import 'widget.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({super.key});
  Widget _imagePageWidget({required Widget body, required Widget background}) {
    return Stack(children: [background, body]);
  }

  Widget _buildBody() {
    return const ImageBody();
  }

  Widget _buildBackground(BuildContext context) {
    return Container(color: MyTheme.background);
    // final screenSize = MediaQuery.of(context).size;
    // return Image.asset('assets/images/菜单背景.webp',
    //     width: screenSize.width, height: screenSize.height, fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: const BackButton(color: Colors.white),
            title: Text('图鉴', style: MyTheme.bigStyle),
            backgroundColor: MyTheme.background51),
        // floatingActionButton: FloatingActionButton(onPressed: () {}),
        body: _imagePageWidget(
            body: _buildBody(), background: _buildBackground(context)));
  }
}
