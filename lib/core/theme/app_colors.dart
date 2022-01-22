import 'package:flutter/material.dart';

abstract class AppColors {
  Color get example;
}

class AppColorsLight implements AppColors {
  @override
  Color get example => const Color(0xFF40B28C);
}

class AppColorsDark implements AppColors {
  @override
  Color get example => const Color(0xFF40B28C);
}
