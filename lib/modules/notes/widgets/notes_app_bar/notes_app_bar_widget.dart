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
  final Map<String, String> menuList;
  NotesAppBarWidget({
    Key? key,
    required this.user,
    required this.onTap,
    required this.menuSelect,
    required this.menuList,
  }) : super(
          key: key,
          preferredSize: Size.fromHeight(16.h),
          child: Builder(builder: (context) {
            return Semantics(
              container: true,
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: AppConfigController().colorStatus(isWhite: true),
                child: Material(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: 16.h,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: AppTheme.gradients.background),
                        padding:
                            EdgeInsets.only(left: 24, right: 4.1, top: 7.h),
                        height: 16.h,
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    user.photoUrl,
                                    width: 7.h,
                                    height: 7.h,
                                  ),
                                ),
                                SizedBox(width: 4.w),
                                Expanded(
                                  child: Text(
                                    capitalize(user.name.toLowerCase()),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: AppTheme.textStyles.textAppBar,
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 2.w),
                                    child: Wrap(
                                      children: <Widget>[
                                        MenuAppBarWidget(
                                          onSelected: menuSelect,
                                          options: menuList,
                                          height: 3.5.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
}
