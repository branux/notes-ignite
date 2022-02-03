import '/domain/login/model/user_model.dart';
import '/domain/login/repository/login_repository.dart';

abstract class LoginUseCase {
  Future<UserModel> googleSignIn();
  Future<bool> signOutGoogle();
  Future<UserModel> isConnectGoogle();
}

class LoginUseCaseImpl implements LoginUseCase {
  LoginRepository repository = LoginRepository();

  // LOGAR COM GOOGLE (USECASE VOCÊ PODE FAZER GERENCIAMENTO DO USER)
  @override
  Future<UserModel> googleSignIn() async {
    try {
      // LOGAR COM GOOGLE
      UserModel user = await repository.googleSignIn();
      await repository.authAddShared(user);
      // throw "Teste falha";
      return user;
    } catch (e) {
      await signOutGoogle();
      rethrow;
    }
  }

  @override
  Future<bool> signOutGoogle() async {
    try {
      return await repository.authDeleteShared();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<UserModel> isConnectGoogle() async {
    try {
      UserModel auth = await repository.authSharedPreferences();
      return auth;
    } catch (e) {
      rethrow;
    }
  }

  void dispose() {
    repository.dispose();
  }
}
