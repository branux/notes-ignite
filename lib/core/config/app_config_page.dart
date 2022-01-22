import '/modules/splash/splash_page.dart';

import '/core/core.dart';
import 'package:flutter/material.dart';

class AppConfigPage extends StatefulWidget {
  const AppConfigPage({
    Key? key,
  }) : super(key: key);

  @override
  _AppConfigPageState createState() => _AppConfigPageState();
}

class _AppConfigPageState extends State<AppConfigPage> {
  //CONTROLADOR COM FUNÇÕES DO TEMA
  final AppConfigController _controllerConfig = AppConfigController();

  late Future<void> _initialize;

  @override
  void initState() {
    // INICIALIZA TODAS AS CONFIGURAÇÕES DO APP
    _initialize = _controllerConfig.initialConfiguration();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // FUNÇÃO QUE INICIALIZA O FUTURE E COMEÇA A TESTAR OS CASOS
      future: _initialize,
      builder: (context, snapshot) {
        // VERIFICA SE RETORNOU ERRO NA FUNÇÃO FUTURE
        if (snapshot.hasError) {
          return const Material(
            child: Center(
              child: Text(
                "Não foi possível inicializar as configurações do APP",
                textDirection: TextDirection.ltr,
              ),
            ),
          );
        }
        // VERIFICA SE RETORNOU COMPLETOU A FUNÇÃO NA FUNÇÃO FUTURE
        // E MANDA PARA PROXIMA ROTA
        if (snapshot.connectionState == ConnectionState.done) {
          if (_controllerConfig.appInicialized) {
            _controllerConfig.appInicialized = false;
            return SplashPage(
              redirect: true,
              key: UniqueKey(),
            );
          }
        }
        // ENQUANTO ESTÁ EM ESTADO DE LOADING NA FUNÇÃO FUTURE
        return SplashPage(
          redirect: false,
          key: UniqueKey(),
        );
      },
    );
  }
}
