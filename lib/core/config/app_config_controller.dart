//import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization/localization.dart';
import 'package:mobx/mobx.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core.dart';
//import '/firebase_options.dart';
part 'app_config_controller.g.dart';

enum StoreState { initial, loading, loaded }

class AppConfigController extends _AppConfigControllerBase
    with _$AppConfigController {
  static final AppConfigController _instance = AppConfigController._internal();

  // passes the instantiation to the _instance object
  factory AppConfigController() => _instance;

  //initialize variables in here
  AppConfigController._internal();
}

abstract class _AppConfigControllerBase with Store {
  AppThemeController controllerAppTheme = AppThemeController();
  VersionInfo versionInfo = VersionInfo();

  static Locale localeSystem() {
    String deviceLanguage = Platform.localeName.substring(0, 2);
    String deviceCountry = Platform.localeName.substring(3, 5);
    return Locale(deviceLanguage, deviceCountry);
  }

  @observable
  ObservableFuture<Locale>? _localeFuture;

  @observable
  Locale _locale = localeSystem();

  @computed
  Locale get locale => _locale;

  @observable
  String? errorMessage;

  @computed
  StoreState get state {
    if (_localeFuture == null ||
        _localeFuture!.status == FutureStatus.rejected) {
      return StoreState.initial;
    }
    return _localeFuture!.status == FutureStatus.pending
        ? StoreState.loading
        : StoreState.loaded;
  }

  @action
  Future<bool> setLocale(Locale locale) async {
    try {
      errorMessage = null;
      await LocalJsonLocalization.delegate.load(locale);
      _localeFuture = ObservableFuture(saveLocale(locale));
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      _locale = await _localeFuture!;
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    }
  }

  @action
  Future<bool> setStringLocale(String? locale) async {
    Locale? localeModify;
    if (locale == 'es') {
      localeModify = const Locale('es', 'ES');
    } else if (locale == 'en') {
      localeModify = const Locale('en', 'US');
    } else if (locale == 'pt') {
      localeModify = const Locale('pt', 'BR');
    }
    try {
      if (localeModify != null) await setLocale(localeModify);
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    }
  }

  Future<Locale> saveLocale(Locale locale) async {
    try {
      final SharedPreferences instance = await SharedPreferences.getInstance();
      await instance.setString("languageCode", locale.languageCode);
      await instance.setString("countryCode", locale.countryCode ?? "");
      return locale;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> currentLocale() async {
    try {
      final SharedPreferences instance = await SharedPreferences.getInstance();
      if (instance.containsKey("languageCode")) {
        String languageCode = instance.getString("languageCode") as String;
        String? countryCode;
        if (instance.containsKey("countryCode")) {
          countryCode = instance.getString("countryCode");
        }
        await setLocale(Locale(languageCode, countryCode));
      } else {
        await setLocale(_locale);
      }
    } catch (e) {
      rethrow;
    }
  }

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
    try {
      await controllerAppTheme.currentThemeMode();
      await currentLocale();
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
