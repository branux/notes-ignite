//LOGIN ABSTRATA PARA GENERALIZAR
import '/domain/login/model/user_model.dart';

abstract class LoginState {}

//LOGIN VAZIA QUANDO INICIA
class LoginStateEmpty extends LoginState {}

//LOGIN LOADING QUANDO INICIA O CARREGAMENTO
class LoginStateLoading extends LoginState {}

//LOGIN FALHA QUANDO FALHA O CARREGAMENTO
class LoginStateFailure extends LoginState {
  final String message;
  LoginStateFailure({
    required this.message,
  });
}

//LOGIN SUCESSO QUANDO DA SUCESSO O CARREGAMENTO
class LoginStateSuccess extends LoginState {
  final UserModel user;
  LoginStateSuccess({
    required this.user,
  });
}
