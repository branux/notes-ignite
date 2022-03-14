import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    bool dark = configController.controllerAppTheme.themeMode == ThemeMode.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppConfigController().colorStatus(isWhite: false),
      child: Scaffold(
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
                        padding: EdgeInsets.symmetric(vertical: 10.w),
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
              padding: EdgeInsets.symmetric(horizontal: 4.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 57.w,
                    child: Text(
                      I18nConst.textLogin,
                      style: AppTheme.textStyles.textGradient,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Observer(builder: (context) {
                    Widget button = (_loginController.loginState
                            is LoginStateLoading)
                        ? SizedBox(
                            height: 26.4.h,
                            child: const Center(
                                child: CircularProgressIndicator()))
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
                              SizedBox(height: 1.4.h),
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
                              SizedBox(height: 15.h),
                            ],
                          );

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (Widget child,
                              Animation<double> animation) =>
                          SizeTransition(child: child, sizeFactor: animation),
                      child: button,
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
