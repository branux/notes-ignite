// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_theme_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppThemeController on _AppThemeControllerBase, Store {
  Computed<ThemeMode>? _$themeModeComputed;

  @override
  ThemeMode get themeMode =>
      (_$themeModeComputed ??= Computed<ThemeMode>(() => super.themeMode,
              name: '_AppThemeControllerBase.themeMode'))
          .value;

  final _$_themeModeAtom = Atom(name: '_AppThemeControllerBase._themeMode');

  @override
  ThemeMode? get _themeMode {
    _$_themeModeAtom.reportRead();
    return super._themeMode;
  }

  @override
  set _themeMode(ThemeMode? value) {
    _$_themeModeAtom.reportWrite(value, super._themeMode, () {
      super._themeMode = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_AppThemeControllerBase.errorMessage');

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$setThemeModeAsyncAction =
      AsyncAction('_AppThemeControllerBase.setThemeMode');

  @override
  Future<bool> setThemeMode(ThemeMode? themeMode) {
    return _$setThemeModeAsyncAction.run(() => super.setThemeMode(themeMode));
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
themeMode: ${themeMode}
    ''';
  }
}
