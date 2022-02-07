import 'package:flutter/material.dart';
import 'package:notes_ignite/core/core.dart';

class IconWidget extends StatelessWidget {
  final Color? color;
  final IconData icon;
  final Color backgroundColor;
  const IconWidget({
    Key? key,
    this.color,
    required this.icon,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Icon(
          icon,
          color: color ?? AppTheme.colors.bodyIconColorSettings,
          size: 30,
        ),
      ),
    );
  }
}
