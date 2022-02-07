//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
//import '/firebase_options.dart';

import '../core.dart';

class AppConfigController {
  static final AppConfigController _instance = AppConfigController._internal();

  // passes the instantiation to the _instance object
  factory AppConfigController() => _instance;

  //initialize variables in here
  AppConfigController._internal();

  AppThemeController controllerAppTheme = AppThemeController();
  VersionInfo versionInfo = VersionInfo();

  SystemUiOverlayStyle colorStatus({required bool isWhite}) {
    if (controllerAppTheme.themeMode == ThemeMode.dark && !isWhite) {
      isWhite = true;
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // cor da barra superior
      statusBarIconBrightness: isWhite
          ? Brightness.light
          : Brightness.dark, // ícones da barra superior
    ));
    return isWhite ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;
  }

  Future<bool> initialConfiguration() async {
    // INICIA O FIREBASE
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    // INICIA AS CORES DO TEMA
    try {
      await controllerAppTheme.currentThemeMode();
      return true;
    } catch (e) {
      return false;
    }
  }
}

class UtilsConst {
  //SERVIDOR
  static String server = "http://10.0.2.2/";
}

class VersionInfo {
  static final VersionInfo _singleton = VersionInfo._internal();
  late PackageInfo versionInfo;
  factory VersionInfo({PackageInfo? newVersion}) {
    if (newVersion != null) _singleton.versionInfo = newVersion;
    return _singleton;
  }

  VersionInfo._internal();
}
