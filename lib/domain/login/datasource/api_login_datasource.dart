import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';

abstract class IApiLoginDatasource {
  Future<GoogleSignInAccount> googleSignIn();
  Future<void> googleSignOut();
  void dispose();
}

class ApiLoginDatasource implements IApiLoginDatasource {
  // LOGAR COM GOOGLE - USA FUNÇÕES PARA SE CONECTAR COM O GOOGLE SIGN IN
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  @override
  Future<GoogleSignInAccount> googleSignIn() async {
    try {
      GoogleSignInAccount? user = await _googleSignIn.signIn();
      if (user != null) {
        return user;
      } else {
        throw I18nConst.loginNull;
      }
    } catch (error) {
      throw I18nConst.errorLogin;
    }
  }

  @override
  Future<void> googleSignOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      throw I18nConst.errorLogout;
    }
  }

  @override
  void dispose() {}
}
