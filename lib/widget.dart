import 'package:flutter/material.dart';

import 'theme/color.dart';

Widget cilpWidget(
    {required double width,
    required double height,
    required double yOffset,
    required Widget child}) {
  return SizedBox(
      width: double.infinity,
      child: FittedBox(
          child: SizedBox(
              width: width,
              height: height,
              child:
                  Stack(children: [Positioned(top: yOffset, child: child)]))));
}

Widget buildDefaultItem(
    {required IconData leading,
    required String title,
    String? subTitle,
    Widget? button,
    Function? onTap}) {
  return GestureDetector(
      onTap: () => onTap?.call(),
      child: ListTile(
          leading:
              Icon(leading, color: Colors.grey, size: MyTheme.narmalIconSize),
          title: Text(title, style: MyTheme.bigStyle),
          subtitle: subTitle == null
              ? null
              : Text(subTitle,
                  style: MyTheme.narmalStyle.copyWith(fontSize: 12)),
          trailing: button ??
              const Icon(Icons.arrow_forward_ios,
                  color: Colors.grey, size: 20)));
}

Widget buildCard(
    {required List<Widget> children,
    bool padding = false,
    bool addLine = true}) {
  Widget line = Container(
      height: 1,
      color: const Color.fromARGB(255, 57, 57, 57),
      margin: const EdgeInsets.symmetric(horizontal: 30));
  if (children.length >= 2) {
    for (int index = 0; index < children.length; index++) {
      int result = index % 2;
      if (result == 1) {
        if (addLine) children.insert(index, line);
      }
    }
  }
  return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
          color: MyTheme.foreground,
          padding: EdgeInsets.all(padding ? 10 : 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children)));
}
