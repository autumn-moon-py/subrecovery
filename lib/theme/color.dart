import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTheme {
  static bool isAndroid = Platform.isAndroid;
  static Color background =
      isAndroid ? PhoneTheme.background : PcTheme.background;
  static Color foreground =
      isAndroid ? PhoneTheme.foreground : PcTheme.foreground;
  static Color background51 =
      isAndroid ? PhoneTheme.background51 : PcTheme.background51;
  static Color foreground62 =
      isAndroid ? PhoneTheme.foreground62 : PcTheme.foreground62;
  static TextStyle miniStyle =
      isAndroid ? PhoneTheme.miniStyle : PcTheme.miniStyle;
  static TextStyle narmalStyle =
      isAndroid ? PhoneTheme.narmalStyle : PcTheme.narmalStyle;
  static TextStyle bigStyle =
      isAndroid ? PhoneTheme.bigStyle : PcTheme.bigStyle;
  static double minIconSize =
      isAndroid ? PhoneTheme.minIconSize : PcTheme.minIconSize;
  static double narmalIconSize =
      isAndroid ? PhoneTheme.narmalIconSize : PcTheme.narmalIconSize;
  static double bigIconSize =
      isAndroid ? PhoneTheme.bigIconSize : PcTheme.bigIconSize;
}

class PhoneTheme {
  static Color background = const Color.fromRGBO(31, 31, 41, 1);
  static Color foreground = const Color.fromRGBO(37, 39, 51, 1);
  static Color background51 = const Color.fromRGBO(37, 39, 51, 1);
  static Color foreground62 = const Color.fromRGBO(48, 50, 62, 1);
  static TextStyle miniStyle =
      const TextStyle(color: Colors.white, fontSize: 13);
  static TextStyle narmalStyle =
      const TextStyle(color: Colors.white, fontSize: 15);
  static TextStyle bigStyle =
      const TextStyle(color: Colors.white, fontSize: 17);
  static double minIconSize = 20;
  static double narmalIconSize = 25;
  static double bigIconSize = 35;
}

class PcTheme {
  static Color background = const Color.fromRGBO(31, 31, 41, 1);
  static Color foreground = const Color.fromRGBO(37, 39, 51, 1);
  static Color background51 = const Color.fromRGBO(37, 39, 51, 1);
  static Color foreground62 = const Color.fromRGBO(48, 50, 62, 1);
  static TextStyle miniStyle = TextStyle(color: Colors.white, fontSize: 10.sp);
  static TextStyle narmalStyle =
      TextStyle(color: Colors.white, fontSize: 15.sp);
  static TextStyle bigStyle = TextStyle(color: Colors.white, fontSize: 15.sp);
  static double minIconSize = 50.r;
  static double narmalIconSize = 70.r;
  static double bigIconSize = 90.r;
}
