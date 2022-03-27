import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:notes_ignite/domain/login/model/user_model.dart';
import 'package:notes_ignite/domain/login/usecase/login_usecase.dart';
import 'package:notes_ignite/modules/login/login_controller.dart';
import 'package:notes_ignite/modules/login/login_state.dart';

class LoginUseCaseMock extends mocktail.Mock implements ILoginUseCase {}

void main() {
  late LoginController loginController;
  late ILoginUseCase loginUseCase;
  late UserModel user;
  setUp(() {
    loginUseCase = LoginUseCaseMock();
    loginController = LoginController(
      loginUseCase: loginUseCase,
    );
    user = UserModel(
      name: "Usuário Teste",
      email: "usuario@teste.com.br",
      id: "1",
      photoUrl: 'teste.png',
    );
  });

  test('Testando googleSignIn Success', () async {
    final states = <LoginState>[];
    mobx.autorun((_) {
      states.add(loginController.loginState);
    });
    mocktail
        .when(loginUseCase)
        .calls(#googleSignIn)
        .thenAnswer((_) => Future.value(user));

    await loginController.googleSignIn();
    expect(states[0], isInstanceOf<LoginStateEmpty>());
    expect(states[1], isInstanceOf<LoginStateLoading>());
    expect(states[2], isInstanceOf<LoginStateSuccess>());
    expect((loginController.loginState as LoginStateSuccess).result,
        isInstanceOf<UserModel>());
    expect((loginController.loginState as LoginStateSuccess).result, user);
    expect((loginController.loginState as LoginStateSuccess).message,
        isInstanceOf<String>());
    expect((loginController.loginState as LoginStateSuccess).message,
        "Login success!");
  });
  test('Testando googleSignIn Failure', () async {
    final states = <LoginState>[];
    mobx.autorun((_) {
      states.add(loginController.loginState);
    });
    mocktail.when(loginUseCase).calls(#googleSignIn).thenThrow('Erro no login');

    await loginController.googleSignIn();
    expect(states[0], isInstanceOf<LoginStateEmpty>());
    expect(states[1], isInstanceOf<LoginStateLoading>());
    expect(states[2], isInstanceOf<LoginStateFailure>());
    expect((loginController.loginState as LoginStateFailure).message,
        isInstanceOf<String>());
    expect((loginController.loginState as LoginStateFailure).message,
        'Erro no login');
  });
}
