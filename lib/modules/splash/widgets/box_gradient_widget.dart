import 'package:flutter/material.dart';

import '/core/core.dart';

class BoxGradientWidget extends StatelessWidget {
  final double width;
  final double height;
  final bool invert;
  const BoxGradientWidget({
    Key? key,
    required this.width,
    required this.height,
    this.invert = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.2,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          gradient:
              invert ? AppTheme.gradients.boxInvert : AppTheme.gradients.box,
        ),
      ),
    );
  }
}
