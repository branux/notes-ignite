// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppConfigController on _AppConfigControllerBase, Store {
  Computed<Locale>? _$localeComputed;

  @override
  Locale get locale =>
      (_$localeComputed ??= Computed<Locale>(() => super.locale,
              name: '_AppConfigControllerBase.locale'))
          .value;
  Computed<StoreState>? _$stateComputed;

  @override
  StoreState get state =>
      (_$stateComputed ??= Computed<StoreState>(() => super.state,
              name: '_AppConfigControllerBase.state'))
          .value;

  final _$_localeFutureAtom =
      Atom(name: '_AppConfigControllerBase._localeFuture');

  @override
  ObservableFuture<Locale>? get _localeFuture {
    _$_localeFutureAtom.reportRead();
    return super._localeFuture;
  }

  @override
  set _localeFuture(ObservableFuture<Locale>? value) {
    _$_localeFutureAtom.reportWrite(value, super._localeFuture, () {
      super._localeFuture = value;
    });
  }

  final _$_localeAtom = Atom(name: '_AppConfigControllerBase._locale');

  @override
  Locale get _locale {
    _$_localeAtom.reportRead();
    return super._locale;
  }

  @override
  set _locale(Locale value) {
    _$_localeAtom.reportWrite(value, super._locale, () {
      super._locale = value;
    });
  }

  final _$errorMessageAtom =
      Atom(name: '_AppConfigControllerBase.errorMessage');

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

  final _$setLocaleAsyncAction =
      AsyncAction('_AppConfigControllerBase.setLocale');

  @override
  Future<bool> setLocale(Locale locale) {
    return _$setLocaleAsyncAction.run(() => super.setLocale(locale));
  }

  final _$setStringLocaleAsyncAction =
      AsyncAction('_AppConfigControllerBase.setStringLocale');

  @override
  Future<bool> setStringLocale(String? locale) {
    return _$setStringLocaleAsyncAction
        .run(() => super.setStringLocale(locale));
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
locale: ${locale},
state: ${state}
    ''';
  }
}
