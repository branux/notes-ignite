import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';
import '/modules/login/login_state.dart';
import '/core/core.dart';

import 'package:sizer/sizer.dart';

import 'login_controller.dart';
import 'widgets/button_social/button_social_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _loginController = LoginController();

  final AppConfigController configController = AppConfigController();
  @override
  void initState() {
    _loginController.autoRun(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    double width = Orientation.portrait == orientation ? (100.w) : (105.h);
    double height = Orientation.portrait == orientation ? (100.h) : (105.w);
    bool dark = configController.controllerAppTheme.themeMode == ThemeMode.dark;
    configController.colorStatus(isWhite: false);
    return Scaffold(
      backgroundColor: AppTheme.colors.background,
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: .10 * height),
                      child: Image.asset(
                        AppTheme.images.backgroundLogin,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: .04 * height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: .33 * height),
                SizedBox(
                  width: .55 * width,
                  child: Text(
                    I18nConst.textLogin,
                    style: AppTheme.textStyles.textGradient,
                  ),
                ),
                SizedBox(height: .04 * height),
                Observer(builder: (context) {
                  Widget button = (_loginController.loginState
                          is LoginStateLoading)
                      ? SizedBox(
                          height: .16 * height,
                          child:
                              const Center(child: CircularProgressIndicator()))
                      : Column(
                          children: [
                            ButtonSocialWidget(
                              text: I18nConst.textButtonGoogle,
                              tooltip: I18nConst.textTooltipGoogle,
                              imagePath: AppTheme.images.iconGoogle,
                              onTap: () => (_loginController.loginState
                                      is LoginStateLoading)
                                  ? null
                                  : _loginController.googleSignIn(),
                            ),
                            SizedBox(height: .014 * height),
                            ButtonSocialWidget(
                              text: I18nConst.textButtonApple,
                              tooltip: I18nConst.textTooltipApple,
                              imagePath: AppTheme.images.iconApple,
                              onTap: () async => (_loginController.loginState
                                      is LoginStateLoading)
                                  ? null
                                  : await configController.controllerAppTheme
                                      .setThemeMode(
                                      dark ? ThemeMode.light : ThemeMode.dark,
                                    ),
                            ),
                          ],
                        );

                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) =>
                            SizeTransition(child: child, sizeFactor: animation),
                    child: button,
                  );
                }),
              ],
            ),
          ),
        ],
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
