import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core.dart';

abstract class AppTextStyles {
  TextStyle get example;
}

class AppTextStylesDefault implements AppTextStyles {
  @override
  TextStyle get example => GoogleFonts.montserrat(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        height: 45 / 40,
        foreground: Paint()
          ..shader = AppTheme.gradients.example
              .createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
      );
}
