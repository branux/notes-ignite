import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '/core/core.dart';

class ButtonSocialWidget extends StatefulWidget {
  final String? imagePath;
  final String? tooltip;
  final IconData? icon;
  final Color? colorIcon;
  final VoidCallback? onTap;
  final String text;
  const ButtonSocialWidget({
    Key? key,
    this.imagePath,
    this.icon,
    this.onTap,
    required this.text,
    this.colorIcon,
    this.tooltip,
  }) : super(key: key);

  @override
  _ButtonSocialWidgetState createState() => _ButtonSocialWidgetState();
}

class _ButtonSocialWidgetState extends State<ButtonSocialWidget> {
  late Widget iconButton;

  void configWidget() {
    if (widget.imagePath != null) {
      iconButton = Image.asset(
        widget.imagePath!,
        width: 24,
        color: widget.colorIcon,
      );
    } else if (widget.icon != null) {
      iconButton = Icon(
        widget.icon!,
        size: 24,
        color: widget.colorIcon,
      );
    } else {
      iconButton = Icon(
        Icons.account_circle_outlined,
        size: 24,
        color: widget.colorIcon,
      );
    }
  }

  @override
  void initState() {
    configWidget();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    configWidget();
    return Material(
      color: AppTheme.colors.background,
      child: Tooltip(
        message: widget.tooltip ?? "",
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: InkWell(
          onTap: widget.onTap,
          child: IntrinsicHeight(
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.colors.border),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: iconButton,
                  ),
                  VerticalDivider(
                    thickness: 1,
                    width: 1,
                    color: AppTheme.colors.border,
                  ),
                  Expanded(
                    child: Text(
                      widget.text,
                      style: AppTheme.textStyles.textSimple,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
