import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:notes_ignite/core/config/app_config_controller.dart';
import 'package:notes_ignite/domain/login/usecase/login_usecase.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';
import 'package:notes_ignite/modules/settings/settings_controller.dart';
import 'package:notes_ignite/modules/settings/settings_state.dart';

class LoginUseCaseMock extends mocktail.Mock implements ILoginUseCase {}

class AppConfigControllerBaseMock extends mocktail.Mock
    implements AppConfigControllerBase {}

void main() {
  late SettingsController controller;
  late ILoginUseCase loginUseCase;
  late AppConfigControllerBase controllerConfig;
  late Locale locale;
  setUp(() {
    loginUseCase = LoginUseCaseMock();
    controllerConfig = AppConfigControllerBaseMock();
    controller = SettingsController(
      authUseCase: loginUseCase,
      controllerConfig: controllerConfig,
    );
    locale = const Locale('pt', 'BR');
  });

  //setLocale
  //signOutGoogle
  test('Testando signOutGoogle Success', () async {
    final states = <SettingsState>[];
    mobx.autorun((_) {
      states.add(controller.state);
    });
    mocktail
        .when(loginUseCase)
        .calls(#signOutGoogle)
        .thenAnswer((_) => Future.value(true));

    await controller.signOutGoogle(() {});
    expect(states[0], isInstanceOf<SettingsStateEmpty>());
    expect(states[1], isInstanceOf<SettingsStateLoading>());
    expect(states[2], isInstanceOf<SettingsStateSuccess>());
    expect((controller.state as SettingsStateSuccess).message,
        isInstanceOf<String>());
    expect((controller.state as SettingsStateSuccess).message,
        "Você foi deslogado com sucesso!");
    expect((controller.state as SettingsStateSuccess).result,
        isInstanceOf<bool>());
    expect((controller.state as SettingsStateSuccess).result, true);
  });

  test('Testando signOutGoogle Failure', () async {
    final states = <SettingsState>[];
    mobx.autorun((_) {
      states.add(controller.state);
    });
    mocktail
        .when(loginUseCase)
        .calls(#signOutGoogle)
        .thenThrow(I18nConst.deletedItemFailed);

    await controller.signOutGoogle(() {});
    expect(states[0], isInstanceOf<SettingsStateEmpty>());
    expect(states[1], isInstanceOf<SettingsStateLoading>());
    expect(states[2], isInstanceOf<SettingsStateFailure>());
    expect((controller.state as SettingsStateFailure).message,
        isInstanceOf<String>());
    expect((controller.state as SettingsStateFailure).message,
        I18nConst.deletedItemFailed);
  });

  test('Testando setLocale Success', () async {
    final states = <SettingsState>[];
    mobx.autorun((_) {
      states.add(controller.state);
    });
    mocktail
        .when(controllerConfig)
        .calls(#setStringLocale)
        .thenAnswer((_) => Future.value(locale));

    await controller.setLocale('pt');
    expect(states[0], isInstanceOf<SettingsStateEmpty>());
    expect(states[1], isInstanceOf<SettingsStateLoading>());
    expect(states[2], isInstanceOf<SettingsStateSuccess>());
    expect((controller.state as SettingsStateSuccess).message,
        isInstanceOf<String>());
    expect((controller.state as SettingsStateSuccess).message,
        "Linguagem modificada com sucesso!");
    expect((controller.state as SettingsStateSuccess).result,
        isInstanceOf<Locale>());
    expect((controller.state as SettingsStateSuccess).result, locale);
  });

  test('Testando setLocale Failure', () async {
    final states = <SettingsState>[];
    mobx.autorun((_) {
      states.add(controller.state);
    });
    mocktail
        .when(controllerConfig)
        .calls(#setStringLocale)
        .thenThrow("Erro ao modificar a linguagem");

    await controller.setLocale('pt');
    expect(states[0], isInstanceOf<SettingsStateEmpty>());
    expect(states[1], isInstanceOf<SettingsStateLoading>());
    expect(states[2], isInstanceOf<SettingsStateFailure>());
    expect((controller.state as SettingsStateFailure).message,
        isInstanceOf<String>());
    expect((controller.state as SettingsStateFailure).message,
        "Erro ao modificar a linguagem");
  });
}
