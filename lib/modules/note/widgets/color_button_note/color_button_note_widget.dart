import 'package:flutter/material.dart';

import 'package:notes_ignite/core/core.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';
import 'package:sizer/sizer.dart';

class ColorButtonNoteWidget extends StatefulWidget {
  final VoidCallback onPressed;
  final Color colorInit;
  final Color colorFinal;
  final bool expanded;

  const ColorButtonNoteWidget({
    Key? key,
    required this.onPressed,
    required this.colorInit,
    required this.colorFinal,
    this.expanded = false,
  }) : super(key: key);

  @override
  State<ColorButtonNoteWidget> createState() => _ColorButtonNoteWidgetState();
}

class _ColorButtonNoteWidgetState extends State<ColorButtonNoteWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animationColor;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animationColor =
        ColorTween(begin: widget.colorInit, end: widget.colorFinal)
            .animate(_animationController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    double borderWidth = 0.3.w;
    Widget colorButtonNoteWidget = AnimatedBuilder(
        animation: _animationColor,
        builder: (context, child) {
          return ElevatedButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                widget.onPressed();
              },
              style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(Size(5.w, 24.sp)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(_animationColor.value),
                  side: MaterialStateProperty.all<BorderSide>(BorderSide(
                      color: AppTheme.colors.border, width: borderWidth)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.zero)),
              child: SizedBox(
                child: Center(
                    child: Text(
                  I18nConst.colors,
                  style: AppTheme.textStyles.buttonColor,
                )),
              ));
        });
    return widget.expanded
        ? Expanded(child: colorButtonNoteWidget)
        : Container(child: colorButtonNoteWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
