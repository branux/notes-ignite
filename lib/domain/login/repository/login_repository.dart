import 'package:google_sign_in/google_sign_in.dart';

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

  void dispose() {
    api.dispose();
  }
}
