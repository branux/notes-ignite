import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '/core/core.dart';
import '/domain/login/model/user_model.dart';
import 'widgets/menu_app_bar_widget.dart';

class NotesAppBarWidget extends PreferredSize {
  static String capitalize(String s) =>
      s[0].toUpperCase() + s.substring(1).split(" ")[0];
  final UserModel user;
  final VoidCallback onTap;
  final Function(String) menuSelect;
  final List<String> menuList;
  final double height;
  final double width;
  NotesAppBarWidget({
    Key? key,
    required this.user,
    required this.onTap,
    required this.menuSelect,
    required this.menuList,
    required this.height,
    required this.width,
  }) : super(
          key: key,
          preferredSize: Size.fromHeight(0.16 * height),
          child: Semantics(
            container: true,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: AppConfigController().colorStatus(isWhite: true),
              child: Material(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: 0.16 * height,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: AppTheme.gradients.background),
                      padding: const EdgeInsets.only(left: 24, right: 4.1),
                      height: 0.16 * height,
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.only(top: 62),
                            visualDensity:
                                const VisualDensity(vertical: 4, horizontal: 4),
                            title: Text(
                              capitalize(user.name.toLowerCase()),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: AppTheme.textStyles.textAppBar,
                            ),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                user.photoUrl,
                                width: 92,
                                height: 92,
                              ),
                            ),
                            trailing: Material(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Wrap(
                                  children: <Widget>[
                                    MenuAppBarWidget(
                                      onSelected: menuSelect,
                                      options: menuList,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
}
