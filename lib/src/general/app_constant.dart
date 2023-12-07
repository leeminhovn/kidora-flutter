import 'package:flutter/material.dart';
import 'package:kidora/src/modules/app_manager.dart';

class AppConstant {
  static BuildContext get contextApp =>
      AppManager.globalKeyRootMaterial.currentContext!;
  static String get baseApiUrl => "https://api-test.kidora.vn/";
  static String get urlBaseVideo => "https://player.vimeo.com/video/839199639";
  static double get screenWidthTable => 1080;
  static double get screenWidthMobile => 500;
}
