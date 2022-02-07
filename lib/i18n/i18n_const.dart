// ignore: implementation_imports
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
  static String title = "title".i18n(); //
  static String createIn = "create-in".i18n();
  static String deletedItemSuccess = "deleted-item-success".i18n();
  static String deletedItemFailed = "deleted-item-failed".i18n();
  static String menuAbout = "menu-about".i18n();
  static String menuSettings = "menu-settings".i18n();
  static String menuLogout = "menu-logout".i18n();
  static String delete = "delete".i18n();
  static String shared = "shared".i18n();
  static String edit = "edit".i18n();
  static String hintTitle = "hint-title".i18n();
  static String note = "note".i18n();
  static String hintNote = "hint-note".i18n();
  static String cancel = "cancel".i18n();
  static String save = "save".i18n();
  static String saveSuccess = "save-success".i18n();
  static String editSuccess = "edit-success".i18n();
  static String saveFailed = "save-failed".i18n();
  static String editFailed = "edit-failed".i18n();
  static String fieldRequired = "field-required".i18n();
  static String notImportance = "not-importance".i18n();
  static String littleImportance = "little-importance".i18n();
  static String mediumImportance = "medium-importance".i18n();
  static String highImportance = "high-importance".i18n();
  static String veryImportant = "very-importance".i18n();
  static String colors = "colors".i18n();
  static String chooseColor = "choose-color".i18n();
  static String modify = "modify".i18n();

  // TODO: implement
  static String notLocalizedNote = "not-localized-note".i18n();

  static String textErroSnackbar([List<String> arguments = const []]) =>
      "text-erro-snackbar".i18n(arguments);

  static String erroRoute([List<String> arguments = const []]) =>
      "erro-route".i18n(arguments);

  static String loginErroAdd([List<String> arguments = const []]) =>
      "login-erro-add".i18n(arguments);
}
