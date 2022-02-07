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
    Orientation orientation = MediaQuery.of(context).orientation;
    double width = Orientation.portrait == orientation ? (100.w) : (105.h);
    double height = Orientation.portrait == orientation ? (100.h) : (105.w);

    if (widget.imagePath != null) {
      iconButton = Image.asset(
        widget.imagePath!,
        width: 5.w,
        color: widget.colorIcon,
      );
    } else if (widget.icon != null) {
      iconButton = Icon(
        widget.icon!,
        size: 5.w,
        color: widget.colorIcon,
      );
    } else {
      iconButton = Icon(
        Icons.account_circle_outlined,
        size: 5.w,
        color: widget.colorIcon,
      );
    }
  }

  @override
  void didChangeDependencies() {
    configWidget();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    double width = Orientation.portrait == orientation ? (100.w) : (105.h);
    double height = Orientation.portrait == orientation ? (100.h) : (105.w);
    configWidget();
    return Material(
      color: AppTheme.colors.background,
      child: Tooltip(
        message: widget.tooltip ?? "",
        textStyle: AppTheme.textStyles.textTooltip,
        margin: EdgeInsets.symmetric(horizontal: .09 * width),
        padding: EdgeInsets.symmetric(
            vertical: .012 * height, horizontal: .026 * width),
        child: InkWell(
          onTap: widget.onTap,
          child: IntrinsicHeight(
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppTheme.colors.border,
                  width: .35.w,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(2.6.w),
                    child: iconButton,
                  ),
                  VerticalDivider(
                    thickness: .35.w,
                    width: .35.w,
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
