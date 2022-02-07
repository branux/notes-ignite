import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';

class ApiLoginDatasource {
  // LOGAR COM GOOGLE - USA FUNÇÕES PARA SE CONECTAR COM O GOOGLE SIGN IN
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  Future<GoogleSignInAccount> googleSignIn() async {
    try {
      GoogleSignInAccount? user = await _googleSignIn.signIn();
      if (user != null) {
        return user;
      } else {
        throw I18nConst.loginNull;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> googleSignOut() async {
    try {
      await _googleSignIn.signOut();
      return;
    } catch (e) {
      rethrow;
    }
  }

  void dispose() {}
}
