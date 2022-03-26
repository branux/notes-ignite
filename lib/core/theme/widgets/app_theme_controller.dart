import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'app_theme_controller.g.dart';

class AppThemeController extends _AppThemeControllerBase
    with _$AppThemeController {
  static final AppThemeController _instance = AppThemeController._internal();

  // passes the instantiation to the _instance object
  factory AppThemeController() => _instance;

  //initialize variables in here
  AppThemeController._internal() {
    _themeMode = null;
  }
}

abstract class _AppThemeControllerBase with Store {
  // TEMA ATUAL DO APLICATIVO (É OBSERVADO PELO MOBX)
  @observable
  ThemeMode? _themeMode;

  @observable
  String? errorMessage;

  // QUANDO O TEMA É ALTERADO ELE INFORMA TODOS OS OBSERVERS EXTERNOS
  @computed
  ThemeMode get themeMode => _themeMode ?? ThemeMode.light;

  // SETA O TEMA NOVO QUANDO O USUARIO MUDAR
  // CASO TENHA ALGUM PROBLEMA SETA O TEMA COMO LIGHT
  @action
  Future<bool> setThemeMode(ThemeMode? themeMode) async {
    try {
      await saveThemeMode(themeMode ?? ThemeMode.light);
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    }
  }

  // ALTERA O TEMA SALVO NO SHARED PREFERENCES E MUDA O THEME NO CONTROLLER
  Future<void> saveThemeMode(ThemeMode themeMode) async {
    try {
      final SharedPreferences instance = await SharedPreferences.getInstance();
      await instance.setString("themeMode", themeMode.index.toString());
      _themeMode = themeMode;
    } catch (e) {
      rethrow;
    }
  }

  // PEGA O TEMA CASO EXISTA NO SHARED PREFERENCES
  Future<bool> currentThemeMode() async {
    try {
      final SharedPreferences instance = await SharedPreferences.getInstance();
      late bool result;
      if (instance.containsKey("themeMode")) {
        String? themeMode = instance.getString("themeMode");
        int index = int.parse(themeMode ?? "0");
        if (index == ThemeMode.dark.index) {
          result = await setThemeMode(ThemeMode.dark);
        } else if (index == ThemeMode.light.index) {
          result = await setThemeMode(ThemeMode.light);
        } else {
          result = await setThemeMode(ThemeMode.system);
        }
      } else {
        result = await setThemeMode(null);
      }
      return result;
    } catch (e) {
      return false;
    }
  }
}
