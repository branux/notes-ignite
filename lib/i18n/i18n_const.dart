import 'package:localization/src/localization_extension.dart';

class I18nConst {
  static String textLogin = "text-login".i18n();
  static String textButtonGoogle = "text-button-google".i18n();
  static String textButtonApple = "text-button-apple".i18n();
  static String textTooltipApple = "text-tooltip-apple".i18n();
  static String textTooltipGoogle = "text-tooltip-google".i18n();
  static String erroConfigApp = "erro-config-app".i18n();
  static String loginNull = "login-null".i18n();
  static String loginNotFound = "login-not-found".i18n();
  static String addIcon = "add-icon".i18n();

  static String textErroSnackbar([List<String> arguments = const []]) =>
      "text-erro-snackbar".i18n(arguments);

  static String erroRoute([List<String> arguments = const []]) =>
      "erro-route".i18n(arguments);

  static String loginErroAdd([List<String> arguments = const []]) =>
      "login-erro-add".i18n(arguments);
}
