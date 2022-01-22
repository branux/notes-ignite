import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '/domain/login/usecase/login_usecase.dart';
import '/modules/login/login_state.dart';
import '/core/core.dart';

import 'login_controller.dart';
import 'widgets/button_social/button_social_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _loginController =
      LoginController(loginUseCase: LoginUseCaseImpl());
  @override
  void initState() {
    _loginController.autoRun(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 199,
              child: Text(
                "Divida contas com seus amigos",
                style: AppTheme.textStyles.gradientTitle,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 232,
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Image.asset(
                      AppTheme.images.emoji,
                      height: 36,
                    ),
                    title: Text("Faça seu login com uma das contas abaixo",
                        style: AppTheme.textStyles.textSimple
                            .copyWith(height: 26 / 16)),
                  ),
                ),
                const SizedBox(height: 32),
                Observer(builder: (context) {
                  if (_loginController.loginState is LoginStateLoading) {
                    return const SizedBox(
                        height: 128,
                        child: Center(child: CircularProgressIndicator()));
                  }
                  return Column(
                    children: [
                      ButtonSocialWidget(
                        text: "Entrar com Google",
                        imagePath: AppTheme.images.iconGoogle,
                        onTap: () => _loginController.googleSignIn(),
                      ),
                      const SizedBox(height: 12),
                      ButtonSocialWidget(
                        text: "Entrar com Apple",
                        imagePath: AppTheme.images.iconApple,
                        onTap: () {
                          print("Apple");
                        },
                      ),
                    ],
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Row(children: [
//   Image.asset(
//     AppTheme.images.emoji,
//     height: 36,
//   ),
//   const SizedBox(width: 22),
//   Flexible(
//     child: SizedBox(
//         width: 174,
//         child: Text("Faça seu login com uma das contas abaixo",
//             style: AppTheme.textStyles.textSimple
//                 .copyWith(height: 26 / 16))),
//   ),
// ]),
