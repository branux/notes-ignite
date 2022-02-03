import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core.dart';

abstract class AppTextStyles {
  TextStyle get textGradient;
  TextStyle get textAppBar;
  TextStyle get textSimple;
  TextStyle get textTitle;
  TextStyle get textSubtitle;
  TextStyle get textButton;
  TextStyle get textSubtitleOpacity;
  TextStyle get buttonColor;
  TextStyle get textSelect;
  TextStyle get textSnackBar;
  TextStyle get textAlertDialog;
}

class AppTextStylesDefault implements AppTextStyles {
  @override
  TextStyle get textGradient => GoogleFonts.montserrat(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        height: 45 / 40,
        foreground: Paint()
          ..shader = AppTheme.gradients.textGradient
              .createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
      );

  @override
  TextStyle get textAlertDialog => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppTheme.colors.textSimple,
      );
  @override
  TextStyle get textSimple => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 19.4 / 16,
        color: AppTheme.colors.textSimple,
      );

  @override
  TextStyle get textAppBar => GoogleFonts.montserrat(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 26 / 24,
        color: AppTheme.colors.textGradient,
      );

  @override
  TextStyle get textTitle => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 19.4 / 16,
        color: AppTheme.colors.textTitle,
      );

  @override
  TextStyle get textSubtitle => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 18 / 12,
        color: AppTheme.colors.textSubtitle,
      );

  @override
  TextStyle get textButton => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppTheme.colors.textSubtitle,
      );

  @override
  TextStyle get textSubtitleOpacity => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 18 / 12,
        color: AppTheme.colors.textSubtitleOpacity,
      );

  @override
  TextStyle get buttonColor => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 18 / 15,
        color: AppTheme.colors.textTitle,
      );

  @override
  TextStyle get textSelect => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        height: 15 / 10,
        color: AppTheme.colors.textSimple,
      );

  @override
  TextStyle get textSnackBar => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 19 / 16,
        color: Colors.white,
      );
}
