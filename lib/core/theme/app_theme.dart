import 'package:flutter/material.dart';

import '../core.dart';

class AppTheme {
  static AppColors get colors {
    AppThemeController themeModeContext = AppThemeController();
    ThemeMode _themeModeContext = themeModeContext.themeMode;
    if (_themeModeContext != ThemeMode.dark) {
      return AppColorsLight();
    } else {
      return AppColorsDark();
    }
  }

  static AppTextStyles get textStyles => AppTextStylesDefault();
  static AppImages get images => AppImagesDefault();
  static AppGradients get gradients => AppGradientsDefault();
}
