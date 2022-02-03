import 'package:flutter/material.dart';

import 'package:notes_ignite/core/core.dart';

class ColorButtonNoteWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final bool expanded;

  const ColorButtonNoteWidget({
    Key? key,
    required this.onPressed,
    required this.color,
    this.expanded = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Widget colorButtonNoteWidget = ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color),
            side: MaterialStateProperty.all<BorderSide>(
                BorderSide(color: AppTheme.colors.border, width: 1)),
            padding:
                MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero)),
        child: SizedBox(
          child: Center(
              child: Text(
            "Cores",
            style: AppTheme.textStyles.buttonColor,
          )),
        ));
    return expanded
        ? Expanded(child: colorButtonNoteWidget)
        : Container(child: colorButtonNoteWidget);
  }
}
