import 'package:flutter/material.dart';
import 'package:notes_ignite/domain/login/model/user_model.dart';
import 'package:notes_ignite/domain/login/usecase/login_usecase.dart';
import '/core/core.dart';

class SplashController {
  SplashController({ILoginUseCase? authUseCase}) {
    _authUseCase = authUseCase ?? LoginUseCase();
  }
  late ILoginUseCase _authUseCase;

  // FUNÇÃO PARA REDIRECIONAR A SPLASH PARA LOGIN PAGE OU PARA NOTEPAGE
  void redirectSplash(BuildContext context) async {
    try {
      UserModel user = await _authUseCase.isConnectGoogle();
      Future.delayed(const Duration(seconds: 3)).then((_) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouterClass.notes,
          (Route<dynamic> route) => false,
          arguments: user,
        );
      });
    } catch (e) {
      Future.delayed(const Duration(seconds: 3)).then((_) {
        Navigator.pushNamedAndRemoveUntil(
            context, RouterClass.login, (Route<dynamic> route) => false);
      });
    }
  }
}
