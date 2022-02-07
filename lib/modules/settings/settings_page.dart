import 'package:flutter/material.dart';
import 'package:notes_ignite/shared/settings_widgets/alert_dialog_settings/alert_dialog_settings.dart';
import 'package:notes_ignite/shared/settings_widgets/card_perfil/card_perfil_widget.dart';
import 'package:notes_ignite/shared/settings_widgets/icon_widget/icon_widget.dart';
import 'package:notes_ignite/shared/settings_widgets/settings_group/settings_group_widget.dart';
import 'package:notes_ignite/shared/settings_widgets/simple_settings_tile/simple_settings_tile_widget.dart';
import 'package:notes_ignite/shared/settings_widgets/switch_settings_tile/switch_settings_tile_widget.dart';
import 'package:sizer/sizer.dart';
import '/core/core.dart';
import '/domain/login/model/user_model.dart';
import '/modules/settings/settings_controller.dart';

class SettingsPage extends StatefulWidget {
  final UserModel user;
  const SettingsPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppThemeController controllerTheme = AppThemeController();
  final SettingsController settingsController = SettingsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.bodyBackgroundSettings,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Stack(
              children: [
                Align(
                  alignment: const Alignment(-1, -1),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    iconSize: 32,
                    color: AppTheme.colors.appBarTitleSettings,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(
                  height: 44,
                  child: Center(
                    child: Text(
                      "Configurações",
                      style: AppTheme.textStyles.appBarTitleSettings,
                    ),
                  ),
                ),
              ],
            ),
            CardPerfilWidget(
              user: widget.user,
              callback: () => showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialogSettings(
                  user: widget.user,
                  yesPress: () => Navigator.maybePop(context),
                ),
              ),
            ),
            SwitchSettingsTileWidget(
              leading: IconWidget(
                color: AppTheme.colors.bodyIconColorSettings,
                icon: Icons.dark_mode,
                backgroundColor: const Color(0xFF794BF6),
              ),
              title: "Dark Mode",
              style: AppTheme.textStyles.bodyButtomTitleSettings,
              onChanged: (value) {
                if (value) {
                  controllerTheme.setThemeMode(ThemeMode.dark);
                } else {
                  controllerTheme.setThemeMode(ThemeMode.light);
                }
              },
              switchValue: controllerTheme.themeMode == ThemeMode.dark,
            ),
            SizedBox(height: 2.5.h),
            SettingsGroup(
              title: 'GENERAL',
              style: AppTheme.textStyles.bodyTitleSettings,
              children: [
                SimpleSettingsTile(
                  title: "Notificações",
                  subtitle: "",
                  style: AppTheme.textStyles.bodyButtomTitleSettings,
                  leading: IconWidget(
                    color: AppTheme.colors.bodyIconColorSettings,
                    icon: Icons.notifications,
                    backgroundColor: Colors.redAccent,
                  ),
                  child: Container(),
                  onTap: () {},
                ),
                SizedBox(height: 1.5.h),
                SimpleSettingsTile(
                  title: "Sair",
                  subtitle: "",
                  style: AppTheme.textStyles.bodyButtomTitleSettings,
                  leading: IconWidget(
                    color: AppTheme.colors.bodyIconColorSettings,
                    icon: Icons.logout,
                    backgroundColor: Colors.blueAccent,
                  ),
                  onTap: () async {
                    settingsController.signOutGoogle().then((value) {
                      if (value) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RouterClass.login,
                          (route) => false,
                        );
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 1.5.h),
            SettingsGroup(
              title: 'FEEDBACK',
              style: AppTheme.textStyles.bodyTitleSettings,
              children: [
                SimpleSettingsTile(
                  title: "Reportar um bug",
                  subtitle: "",
                  style: AppTheme.textStyles.bodyButtomTitleSettings,
                  leading: IconWidget(
                    color: AppTheme.colors.bodyIconColorSettings,
                    icon: Icons.bug_report,
                    backgroundColor: Colors.teal,
                  ),
                  onTap: () async {},
                ),
                SizedBox(height: 1.5.h),
                SimpleSettingsTile(
                  title: "Enviar FeedBack",
                  subtitle: "",
                  style: AppTheme.textStyles.bodyButtomTitleSettings,
                  leading: IconWidget(
                    color: AppTheme.colors.bodyIconColorSettings,
                    icon: Icons.thumb_up_alt_sharp,
                    backgroundColor: Colors.purple,
                  ),
                  onTap: () async {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
