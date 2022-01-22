import 'dart:math';

import 'package:flutter/material.dart';

abstract class AppGradients {
  Gradient get example;
}

class AppGradientsDefault implements AppGradients {
  @override
  Gradient get example => const LinearGradient(
        colors: [Color(0xFF40B28C), Color(0xFF45CC93)],
        stops: [0, 1],
        transform: GradientRotation((135 / 180) * pi * pi),
      );
}
