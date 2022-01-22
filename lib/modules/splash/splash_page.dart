import 'package:flutter/material.dart';
import '/core/core.dart';
import 'package:sizer/sizer.dart';
import '/modules/splash/splash_controller.dart';

import 'widgets/box_gradient_widget.dart';

class SplashPage extends StatefulWidget {
  final bool redirect;

  const SplashPage({
    Key? key,
    required this.redirect,
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashController splashController = SplashController();

  @override
  void initState() {
    // REDIRECIONAMENTO PARA LOGIN-PAGE
    if (widget.redirect) splashController.redirectSplash(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppTheme.gradients.background),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 9.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BoxGradientWidget(
                        width: 52.w,
                        height: 14.h,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      BoxGradientWidget(
                        height: 9.h,
                        width: 30.w,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BoxGradientWidget(
                        height: 9.h,
                        width: 30.w,
                        invert: true,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      BoxGradientWidget(
                        width: 52.w,
                        height: 14.h,
                        invert: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Center(
                child: Image.asset(AppTheme.images.logo),
              ),
            )
          ],
        ),
      ),
    );
  }
}
