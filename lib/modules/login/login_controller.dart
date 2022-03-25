import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';
import '/core/core.dart';
import '/domain/login/model/user_model.dart';
import '/domain/login/usecase/login_usecase.dart';
import '/modules/login/login_state.dart';
part 'login_controller.g.dart';

class LoginController extends _LoginControllerBase with _$LoginController {
  LoginController({ILoginUseCase? loginUseCase}) {
    _loginUseCase = loginUseCase ?? LoginUseCase();
  }
}

abstract class _LoginControllerBase with Store {
  late ILoginUseCase _loginUseCase;
  @observable
  LoginState loginState = LoginStateEmpty();

  // FUNÇÃO DE AÇÃO PARA LOGAR EM UM USUARIO DA GOOGLE
  @action
  Future<void> googleSignIn() async {
    try {
      // LOGAR COM GOOGLE
      await _modifyLoginState(LoginStateLoading());
      UserModel userModel = await _loginUseCase.googleSignIn();
      await _modifyLoginState(LoginStateSuccess(user: userModel));
    } catch (error) {
      loginState = LoginStateFailure(message: error.toString());
      if (kDebugMode) print(error);
    }
  }

  @action
  Future<void> _modifyLoginState(LoginState state) async => loginState = state;

  // FUNÇÃO PARA ABRIR O SNACKBAR
  void showSnackBar(BuildContext context) {
    SnackBar snackBar = SnackBar(
      content: Text(
        I18nConst.textErroSnackbar([(loginState as LoginStateFailure).message]),
        textAlign: TextAlign.center,
        style: AppTheme.textStyles.textSnackBar,
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  // FUNÇÃO PARA EXECUTAR SEMPRE QUE TIVER UMA ALTERAÇÃO NO LOGINSTATE
  void autoRun(BuildContext context) {
    autorun((_) {
      if (loginState is LoginStateFailure) {
        showSnackBar(context);
      } else if (loginState is LoginStateSuccess) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouterClass.notes,
          (Route<dynamic> route) => false,
          arguments: (loginState as LoginStateSuccess).user,
        );
      }
    });
  }
}
