library appx;

import 'dart:math';
import 'dart:ui';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

part 'navigator.dart';

class Appx{
  static bool get isAndroid => Platform.isAndroid;
  static bool get isIOS => Platform.isIOS;
  static bool get isWindows => Platform.isWindows;
  static bool get isLinux => Platform.isLinux;
  static bool get isDesktop =>
      Platform.isWindows || Platform.isLinux || Platform.isMacOS;
  static bool get isMobile => Platform.isAndroid || Platform.isIOS;

  static GlobalKey<NavigatorState>? _navigatorKey;

  static GlobalKey<NavigatorState> createKey(){
    if(_navigatorKey != null) return _navigatorKey!;
    _navigatorKey = GlobalKey<NavigatorState>();
    return _navigatorKey!;
  }

  static BuildContext? get context => _navigatorKey?.currentContext;

  static back() {
    if (Navigator.canPop(context!)) {
      Navigator.of(context!).pop();
    }
  }

  static to(Widget Function() page) {
    Navigator.of(context!).push(AppPageRoute(page));
  }

  static off(Widget Function() page) {
    Navigator.of(context!)
        .pushAndRemoveUntil(AppPageRoute(page), (route) => false);
  }

  static offAll(Widget Function() page) {
    Navigator.of(context!)
        .pushAndRemoveUntil(AppPageRoute(page), (route) => false);
  }
}