import 'package:flutter/material.dart';
import '/domain/login/model/user_model.dart';
import '/core/config/app_config_page.dart';
import '/modules/splash/splash_page.dart';
import '/modules/login/login_page.dart';

// CLASSE COM TODA REGRA DAS ROTAS DO APLICATIVO
class RouterClass {
  // STRINGS DAS ROTAS
  static const String initial = "/";
  static const String splash = "/splash";
  static const String login = "/login";

  // FUNÇÃO DE GERAÇÃO DE ROTAS
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
    // PROCURA A ROTA
    switch (settings.name) {
      // ROTA DA SPLASH
      case splash:
        return MaterialPageRoute(
            builder: (_) => const SplashPage(redirect: true));

      // ROTA PARA FAZER O LOGIN
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      // // ROTA PARA DO HOME
      // case home:
      //   UserModel user = settings.arguments as UserModel;
      //   return MaterialPageRoute(
      //       builder: (_) => HomePage(
      //             user: user,
      //           ));

      // ROTA COM INICIAL DE CONFIGURAÇÕES
      case initial:
        return MaterialPageRoute(builder: (_) => const AppConfigPage());

      // ROTA CASO NÃO ACHE ROTA
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
                child: Text('Não há rota definida para ${settings.name}')),
          ),
        );
    }
  }
}
