import 'package:flutter/material.dart';
import 'package:notes_ignite/core/core.dart';
import 'package:notes_ignite/domain/login/model/user_model.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';
import 'package:notes_ignite/shared/settings_widgets/cart_text_widget/card_text_widget.dart';
import 'package:sizer/sizer.dart';

class AlertDialogSettings extends StatelessWidget {
  final VoidCallback yesPress;
  final UserModel user;
  const AlertDialogSettings({
    Key? key,
    required this.yesPress,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double borderWidth = 0.3.w;
    double borderRadius = 1.w;
    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      backgroundColor: AppTheme.colors.background,
      title: Container(
        decoration: BoxDecoration(
          color: AppTheme.colors.backgroundColor,
        ),
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        child: Row(
          children: [
            Flexible(
              child: Text(
                I18nConst.infoUser,
                style: AppTheme.textStyles.titleAlertDialog,
              ),
            ),
          ],
        ),
      ),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardTextWidget(
                title: I18nConst.name,
                subtitle: user.name,
              ),
              SizedBox(height: 1.h),
              CardTextWidget(
                title: I18nConst.email,
                subtitle: user.email,
              ),
              SizedBox(height: 1.h),
            ],
          ),
        ),
      ),
      actions: [
        InkWell(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border:
                  Border.all(color: AppTheme.colors.border, width: borderWidth),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
            child: Text(I18nConst.quit, style: AppTheme.textStyles.textButton),
          ),
          onTap: yesPress,
        ),
      ],
    );
  }
}
