import 'package:flutter/material.dart';
import '/core/core.dart';

class SplashController {
  // FUNÇÃO PARA REDIRECIONAR A SPLASH PARA LOGIN PAGE
  void redirectSplash(BuildContext context) {
    Future.delayed(const Duration(seconds: 3)).then((_) =>
        Navigator.pushNamedAndRemoveUntil(
            context, RouterClass.login, (Route<dynamic> route) => false));
  }
}
