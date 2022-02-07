import 'package:flutter/material.dart';
import 'package:notes_ignite/domain/note/model/note_model.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';
import 'package:notes_ignite/modules/note/note_page.dart';
import 'package:notes_ignite/modules/notes/notes_page.dart';
import 'package:notes_ignite/modules/settings/settings_page.dart';
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
  static const String notes = "/notes";
  static const String note = "/note";
  static const String settings = "/settings";

  // FUNÇÃO DE GERAÇÃO DE ROTAS
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    // Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
    // PROCURA A ROTA

    switch (routeSettings.name) {
      // ROTA DA SPLASH
      case splash:
        return MaterialPageRoute(
            builder: (_) => SplashPage(redirect: true, key: UniqueKey()));

      // ROTA PARA FAZER O LOGIN
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage(key: UniqueKey()));

      case notes:
        UserModel user = routeSettings.arguments as UserModel;
        return MaterialPageRoute(
            builder: (_) => NotesPage(key: UniqueKey(), userModel: user));

      case settings:
        UserModel user = routeSettings.arguments as UserModel;
        return MaterialPageRoute(
            builder: (_) => SettingsPage(key: UniqueKey(), user: user));

      case note:
        Map<String, dynamic> arguments =
            routeSettings.arguments as Map<String, dynamic>;
        UserModel user = arguments["user"];
        NoteModel? noteModel = arguments["note"];
        return MaterialPageRoute(
            builder: (_) =>
                NotePage(key: UniqueKey(), noteModel: noteModel, user: user));

      // ROTA COM INICIAL DE CONFIGURAÇÕES
      case initial:
        return MaterialPageRoute(builder: (_) => const AppConfigPage());

      // ROTA CASO NÃO ACHE ROTA
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
                child: Text(
                    I18nConst.textErroSnackbar([routeSettings.name ?? ""]))),
          ),
        );
    }
  }
}
