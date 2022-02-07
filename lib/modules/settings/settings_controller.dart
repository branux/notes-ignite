import 'package:notes_ignite/domain/login/model/user_model.dart';
import 'package:notes_ignite/domain/login/usecase/login_usecase.dart';

class SettingsController {
  LoginUseCase authUseCase = LoginUseCaseImpl();
  Future<bool> signOutGoogle() async {
    try {
      await authUseCase.signOutGoogle();
      return true;
    } catch (e) {
      print("Erro pra sair" + e.toString());
      return false;
    }
  }

  Map<String, dynamic> arguments({
    required UserModel user,
  }) {
    return {
      'user': user,
    };
  }

  // SnackBar showSnackBar(bool sucess) {
  //   return SnackBar(
  //     content: Text(
  //       sucess ? "Enviado com sucesso" : "Falha no envio",
  //       textAlign: TextAlign.center,
  //       style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
  //     ),
  //     backgroundColor: sucess ? Colors.green : Colors.red,
  //   );
  // }

  void dispose() {
    authUseCase.dispose();
  }
}
