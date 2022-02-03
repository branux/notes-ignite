import 'package:flutter/material.dart';

abstract class AppColors {
  Color get example;
  Color get backgroundColor;
  Color get background;
  Color get textGradient;
  Color get textTitle;
  Color get textSimple;
  Color get textSubtitle;
  Color get textSubtitleOpacity;
  Color get border;
  Color get divider;
  Color get icon;
  List<Color> get colorsPicker;
}

class AppColorsLight implements AppColors {
  @override
  Color get example => const Color(0xFF40B28C);

  @override
  Color get background => const Color(0xFFFFFFFF);

  @override
  Color get backgroundColor => const Color(0xFF4721B4);

  @override
  Color get textGradient => const Color(0xFFFFFFFF);

  @override
  Color get textSimple => const Color(0xFF666666);

  @override
  Color get textSubtitle => const Color(0xFF666666);

  @override
  Color get textSubtitleOpacity => const Color(0xFFA4B2AE);

  @override
  Color get textTitle => const Color(0xFF455250);

  @override
  Color get border => const Color(0xFFDCE0E5);

  @override
  Color get divider => const Color(0x33666666);

  @override
  Color get icon => const Color(0xFFFFFFFF);

  @override
  List<Color> get colorsPicker => const [
        Color(0xFFE0F1CF),
        Color(0xFFF1CFCF),
        Color(0xFFF1DDCF),
        Color(0xFFF1EECF),
        Color(0xFFE2F1CF),
        Color(0xFFCFF1D7),
        Color(0xFFCFF1EF),
        Color(0xFFCFD7F1),
        Color(0xFFD8CFF1),
        Color(0xFFF1CFEC),
      ];
}

class AppColorsDark implements AppColors {
  @override
  Color get example => const Color(0xFF40B28C);

  @override
  Color get background => const Color(0xFF333333);

  @override
  Color get backgroundColor => const Color(0xFF4721B4);

  @override
  Color get textGradient => const Color(0xFFFFFFFF);

  @override
  Color get textSimple => const Color(0xFFFFFFFF);

  @override
  Color get textSubtitle => const Color(0xFF666666);

  @override
  Color get textSubtitleOpacity => const Color(0xFFA4B2AE);

  @override
  Color get textTitle => const Color(0xFF455250);

  @override
  Color get border => const Color(0xFF5C5C5C);

  @override
  Color get divider => const Color(0x33666666);

  @override
  Color get icon => const Color(0xFFFFFFFF);

  @override
  List<Color> get colorsPicker => const [
        Color(0xFFE0F1CF),
        Color(0xFFF1CFCF),
        Color(0xFFF1DDCF),
        Color(0xFFF1EECF),
        Color(0xFFE2F1CF),
        Color(0xFFCFF1D7),
        Color(0xFFCFF1EF),
        Color(0xFFCFD7F1),
        Color(0xFFD8CFF1),
        Color(0xFFF1CFEC),
      ];
}
