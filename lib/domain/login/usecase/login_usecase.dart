import '/domain/login/model/user_model.dart';
import '/domain/login/repository/login_repository.dart';

abstract class LoginUseCase {
  Future<UserModel> googleSignIn();
}

class LoginUseCaseImpl implements LoginUseCase {
  LoginRepository repository = LoginRepository();

  // LOGAR COM GOOGLE (USECASE VOCÊ PODE FAZER GERENCIAMENTO DO USER)
  @override
  Future<UserModel> googleSignIn() async {
    try {
      // LOGAR COM GOOGLE
      UserModel user = await repository.googleSignIn();
      // throw "Teste falha";
      return user;
    } catch (e) {
      rethrow;
    }
  }

  void dispose() {
    repository.dispose();
  }
}
