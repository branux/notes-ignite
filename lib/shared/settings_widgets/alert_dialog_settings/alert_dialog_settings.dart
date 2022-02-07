import 'package:flutter/material.dart';
import 'package:notes_ignite/core/core.dart';
import 'package:notes_ignite/domain/login/model/user_model.dart';
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
    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      backgroundColor: AppTheme.colors.background,
      title: Container(
        decoration: BoxDecoration(
          color: AppTheme.colors.backgroundColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        child: Row(
          children: [
            Flexible(
              child: Text(
                "Informações do usuário",
                style: AppTheme.textStyles.textAppBar,
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardTextWidget(
                title: "Nome",
                subtitle: user.name,
              ),
              SizedBox(height: 1.h),
              CardTextWidget(
                title: "E-mail",
                subtitle: user.email,
              ),
              SizedBox(height: 1.h),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text("Sair", style: AppTheme.textStyles.buttonColor),
          ),
          onPressed: yesPress,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white)),
        ),
      ],
    );
  }
}
