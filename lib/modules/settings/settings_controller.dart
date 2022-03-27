import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:notes_ignite/domain/login/model/user_model.dart';
import 'package:notes_ignite/domain/login/usecase/login_usecase.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';
import 'package:notes_ignite/modules/settings/settings_state.dart';

import '../../core/core.dart';
part 'settings_controller.g.dart';

class SettingsController extends _SettingsControllerBase
    with _$SettingsController {
  SettingsController(
      {ILoginUseCase? authUseCase, AppConfigControllerBase? controllerConfig}) {
    _authUseCase = authUseCase ?? LoginUseCase();
    _controllerConfig = controllerConfig ?? AppConfigController();
  }
}

abstract class _SettingsControllerBase with Store {
  late ILoginUseCase _authUseCase;
  late AppConfigControllerBase _controllerConfig;

  @observable
  SettingsState state = SettingsStateEmpty();

  @action
  Future<void> _modifySettingsState(SettingsState stateModify) async =>
      state = stateModify;

  @action
  Future<void> signOutGoogle(Function navigationLogin) async {
    try {
      await _modifySettingsState(SettingsStateLoading());
      final isLogin = await _authUseCase.signOutGoogle();
      await _modifySettingsState(SettingsStateSuccess(
          message: I18nConst.logoutSuccess, result: isLogin));
      navigationLogin();
    } catch (e) {
      await _modifySettingsState(SettingsStateFailure(message: e.toString()));
    }
  }

  @action
  Future<void> setLocale(String? locale) async {
    try {
      await _modifySettingsState(SettingsStateLoading());
      final setLocale = await _controllerConfig.setStringLocale(locale);
      await _modifySettingsState(SettingsStateSuccess(
          message: I18nConst.localeModifySuccess, result: setLocale));
    } catch (e) {
      await _modifySettingsState(SettingsStateFailure(message: e.toString()));
    }
  }

  void navigationLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouterClass.login,
      (route) => false,
    );
  }

  String get locale => _controllerConfig.locale.languageCode;

  Map<String, dynamic> arguments({
    required UserModel user,
  }) =>
      {'user': user};

  // FUNÇÃO PARA ABRIR O SNACKBAR
  void showSnackBar(BuildContext context, String text, Color color) {
    SnackBar snackBar = SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTheme.textStyles.textSnackBar,
      ),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void autoRun(BuildContext context) {
    autorun((_) {
      if (state is SettingsStateFailure) {
        String message = I18nConst.textErroSnackbar(
            [(state as SettingsStateFailure).message]);
        showSnackBar(context, message, Colors.red);
      } else if (state is SettingsStateSuccess) {
        String message = (state as SettingsStateSuccess).message;
        showSnackBar(context, message, Colors.green);
      }
    });
  }

  void dispose() {
    _authUseCase.dispose();
  }
}
