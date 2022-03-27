import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../datasource/api_login_datasource.dart';
import '../model/user_model.dart';

abstract class ILoginRepository {
  Future<UserModel> googleSignIn();
  Future<void> googleSignOut();
  Future<UserModel> authSharedPreferences();
  Future<bool> authDeleteShared();
  Future<bool> authAddShared(UserModel authModel);
  void dispose();
}

class LoginRepository implements ILoginRepository {
  final IApiLoginDatasource _api;
  LoginRepository({ApiLoginDatasource? api})
      : _api = api ?? ApiLoginDatasource();

  // LOGAR COM GOOGLE (REPOSITORY É PARA GERENCIAR A RESPOSTA DA API - TRANSFORMAR USERMODEL)
  @override
  Future<UserModel> googleSignIn() async {
    try {
      GoogleSignInAccount userGoogle = await _api.googleSignIn();
      return UserModel.fromGoogleSignIn(userGoogle);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> googleSignOut() async {
    try {
      return await _api.googleSignOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> authSharedPreferences() async {
    try {
      final SharedPreferences instance = await SharedPreferences.getInstance();
      if (instance.containsKey("user")) {
        String? jsonUser = instance.getString("user");
        if (jsonUser == null) throw I18nConst.loginNotFound;
        UserModel authModel = UserModel.fromJson(jsonUser);
        return authModel;
      } else {
        throw I18nConst.loginNotFound;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> authDeleteShared() async {
    try {
      final SharedPreferences instance = await SharedPreferences.getInstance();
      bool isRemoved = await instance.remove("user");
      return isRemoved ? isRemoved : throw I18nConst.notRemoveUser;
    } catch (e) {
      throw I18nConst.notRemoveUser;
    }
  }

  @override
  Future<bool> authAddShared(UserModel authModel) async {
    try {
      final SharedPreferences instance = await SharedPreferences.getInstance();
      return await instance.setString("user", authModel.toJson());
    } catch (e) {
      throw I18nConst.loginErroAdd([e.toString()]);
    }
  }

  @override
  void dispose() {
    _api.dispose();
  }
}
