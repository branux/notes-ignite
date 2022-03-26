import 'package:flutter/foundation.dart';

import '/domain/login/model/user_model.dart';
import '/domain/login/repository/login_repository.dart';

abstract class ILoginUseCase {
  Future<UserModel> googleSignIn();
  Future<bool> signOutGoogle();
  Future<UserModel> isConnectGoogle();
  void dispose();
}

class LoginUseCase implements ILoginUseCase {
  final ILoginRepository _repository;
  LoginUseCase({ILoginRepository? repository})
      : _repository = repository ?? LoginRepository();

  // LOGAR COM GOOGLE (USECASE VOCÊ PODE FAZER GERENCIAMENTO DO USER)
  @override
  Future<UserModel> googleSignIn() async {
    try {
      // LOGAR COM GOOGLE
      UserModel user = await _repository.googleSignIn();
      await _repository.authAddShared(user);
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
      await _repository.googleSignOut();

      return await _repository.authDeleteShared();
    } catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    }
  }

  @override
  Future<UserModel> isConnectGoogle() async {
    try {
      UserModel auth = await _repository.authSharedPreferences();
      return auth;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
