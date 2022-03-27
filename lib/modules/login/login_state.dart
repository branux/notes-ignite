//LOGIN ABSTRATA PARA GENERALIZAR
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
  final Object result;
  final String message;
  LoginStateSuccess({
    required this.result,
    required this.message,
  });
}
