import 'package:flutter/material.dart';
import '/core/core.dart';

class ButtonBottomBarWidget extends StatefulWidget {
  final bool expanded;
  final String label;
  final VoidCallback onPressed;
  const ButtonBottomBarWidget({
    Key? key,
    required this.label,
    this.expanded = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  _ButtonBottomBarWidgetState createState() => _ButtonBottomBarWidgetState();
}

class _ButtonBottomBarWidgetState extends State<ButtonBottomBarWidget> {
  late Widget buttonBottomBarWidget;
  @override
  void initState() {
    buttonBottomBarWidget = InkWell(
      onTap: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: AppTheme.colors.border, width: 1)),
        ),
        child: Center(
          child: Text(
            widget.label,
            style: AppTheme.textStyles.textButton,
          ),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.expanded
        ? Expanded(child: buttonBottomBarWidget)
        : buttonBottomBarWidget;
  }
}
