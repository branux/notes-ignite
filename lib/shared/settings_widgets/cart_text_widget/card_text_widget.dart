import 'package:flutter/material.dart';
import 'package:notes_ignite/core/core.dart';
import 'package:notes_ignite/shared/settings_widgets/text_form_custom/text_form_custom.dart';
import 'package:sizer/sizer.dart';

class CardTextWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color? colorText;
  const CardTextWidget({
    Key? key,
    required this.title,
    this.subtitle,
    this.colorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (colorText != null) print(colorText!.alpha);
    if (subtitle != null || colorText != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.textStyles.textAlertDialog,
          ),
          if (colorText != null)
            Container(
              color: colorText,
              height: 3.h,
              width: 40.w,
            ),
          if (subtitle != null)
            TextFormCustom(text: subtitle!, disableForm: true),
        ],
      );
    }
    return Container();
  }
}
