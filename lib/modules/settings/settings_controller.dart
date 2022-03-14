import 'package:flutter/foundation.dart';
import 'package:notes_ignite/domain/login/model/user_model.dart';
import 'package:notes_ignite/domain/login/usecase/login_usecase.dart';

import '../../core/core.dart';

class SettingsController {
  late ILoginUseCase _authUseCase;
  late AppConfigController _controllerConfig;

  SettingsController({ILoginUseCase? authUseCase}) {
    _authUseCase = authUseCase ?? LoginUseCase();
    _controllerConfig = AppConfigController();
  }

  Future<bool> signOutGoogle() async {
    try {
      await _authUseCase.signOutGoogle();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Erro pra sair" + e.toString());
      }
      return false;
    }
  }

  Future<void> setLocale(String? locale) async =>
      await _controllerConfig.setStringLocale(locale);

  String get locale => _controllerConfig.locale.languageCode;

  Map<String, dynamic> arguments({
    required UserModel user,
  }) {
    return {
      'user': user,
    };
  }

  // SnackBar showSnackBar(bool sucess) {
  //   return SnackBar(
  //     content: Text(
  //       sucess ? "Enviado com sucesso" : "Falha no envio",
  //       textAlign: TextAlign.center,
  //       style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
  //     ),
  //     backgroundColor: sucess ? Colors.green : Colors.red,
  //   );
  // }

  void dispose() {
    _authUseCase.dispose();
  }
}
