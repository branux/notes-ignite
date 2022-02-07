import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../datasource/api_login_datasource.dart';
import '../model/user_model.dart';

class LoginRepository {
  ApiLoginDatasource api = ApiLoginDatasource();

  // LOGAR COM GOOGLE (REPOSITORY É PARA GERENCIAR A RESPOSTA DA API - TRANSFORMAR USERMODEL)
  Future<UserModel> googleSignIn() async {
    try {
      GoogleSignInAccount userGoogle = await api.googleSignIn();
      return UserModel.fromGoogleSignIn(userGoogle);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> googleSignOut() async {
    try {
      return await api.googleSignOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> authSharedPreferences() async {
    final SharedPreferences instance = await SharedPreferences.getInstance();

    if (instance.containsKey("user")) {
      String? jsonUser = instance.getString("user");
      if (jsonUser == null) throw I18nConst.loginNotFound;
      UserModel authModel = UserModel.fromJson(jsonUser);
      return authModel;
    } else {
      throw I18nConst.loginNotFound;
    }
  }

  Future<bool> authDeleteShared() async {
    final SharedPreferences instance = await SharedPreferences.getInstance();

    print("aaaa user aaaa");
    if (instance.containsKey("user")) {
      return await instance.remove("user");
    } else {
      return false;
    }
  }

  Future<bool> authAddShared(UserModel authModel) async {
    final SharedPreferences instance = await SharedPreferences.getInstance();
    try {
      return await instance.setString("user", authModel.toJson());
    } catch (e) {
      throw I18nConst.loginErroAdd([e.toString()]);
    }
  }

  void dispose() {
    api.dispose();
  }
}
