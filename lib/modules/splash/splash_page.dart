import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '/core/core.dart';
import '/modules/splash/splash_controller.dart';

class SplashPage extends StatefulWidget {
  final bool redirect;

  const SplashPage({
    Key? key,
    required this.redirect,
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  final SplashController splashController = SplashController();
  final AppConfigController configController = AppConfigController();
  late AnimationController animationControllerScale;
  late AnimationController animationControllerTranslate;

  @override
  void initState() {
    animationControllerScale = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..repeat(reverse: true);
    animationControllerTranslate = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..forward();

    // REDIRECIONAMENTO PARA LOGIN-PAGE
    if (widget.redirect) splashController.redirectSplash(context);
    super.initState();
  }

  @override
  void dispose() {
    animationControllerScale.dispose();
    animationControllerTranslate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    double width = Orientation.portrait == orientation ? (100.w) : (112.h);
    configController.colorStatus(isWhite: true);
    return Container(
      decoration: BoxDecoration(gradient: AppTheme.gradients.background),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ScaleTransition(
          scale: Tween<double>(begin: .85, end: 1).animate(
            CurvedAnimation(
              parent: animationControllerScale,
              curve: const Interval(0, 1, curve: Curves.linear),
            ),
          ),
          child: RotationTransition(
            turns: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(CurvedAnimation(
              parent: animationControllerTranslate,
              curve: const Interval(0.1, 1, curve: Curves.bounceOut),
            )),
            child: Center(
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: width * 0.35),
                child: Image.asset(
                  AppTheme.images.logo,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
