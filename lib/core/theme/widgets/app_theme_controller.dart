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

  // QUANDO O TEMA É ALTERADO ELE INFORMA TODOS OS OBSERVERS EXTERNOS
  @computed
  ThemeMode get themeMode {
    if (_themeMode != null) {
      return _themeMode!;
    } else {
      return ThemeMode.system;
    }
  }

  // SETA O TEMA NOVO QUANDO O USUARIO MUDAR
  // CASO TENHA ALGUM PROBLEMA SETA O TEMA COMO LIGHT
  @action
  void setThemeMode(ThemeMode? themeMode) {
    if (themeMode != null) {
      saveThemeMode(themeMode);
    } else {
      saveThemeMode(ThemeMode.system);
    }
  }

  // ALTERA O TEMA SALVO NO SHARED PREFERENCES E MUDA O THEMA NO CONTROLLER
  Future<void> saveThemeMode(ThemeMode themeMode) async {
    _themeMode = themeMode;
    final SharedPreferences instance = await SharedPreferences.getInstance();
    instance.setString("themeMode", themeMode.index.toString());
    return;
  }

  // PEGA O TEMA CASO EXISTA NO SHARED PREFERENCES
  Future<void> currentThemeMode() async {
    final SharedPreferences instance = await SharedPreferences.getInstance();
    if (instance.containsKey("themeMode")) {
      int index = int.parse(instance.get("themeMode") as String);
      if (index == ThemeMode.dark.index) {
        setThemeMode(ThemeMode.dark);
      } else if (index == ThemeMode.light.index) {
        setThemeMode(ThemeMode.light);
      } else if (index == ThemeMode.system.index) {
        setThemeMode(ThemeMode.system);
      }
    } else {
      setThemeMode(null);
    }
  }
}
