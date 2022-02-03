import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/core/core.dart';
import '/domain/login/model/user_model.dart';

class NotesAppBarWidget extends PreferredSize {
  static String capitalize(String s) =>
      s[0].toUpperCase() + s.substring(1).split(" ")[0];
  final UserModel user;
  final VoidCallback onTap;
  NotesAppBarWidget({
    Key? key,
    required this.user,
    required this.onTap,
  }) : super(
          key: key,
          preferredSize: const Size.fromHeight(136),
          child: Semantics(
            container: true,
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: AppConfigController().colorStatus(isWhite: true),
              child: Material(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: 136,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: AppTheme.gradients.background),
                      padding: const EdgeInsets.only(left: 24, right: 4.1),
                      height: 136,
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.only(top: 62),
                            title: Text(
                              capitalize(user.name),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: AppTheme.textStyles.textAppBar,
                            ),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                user.photoUrl,
                                width: 56,
                                height: 56,
                              ),
                            ),
                            trailing: Material(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Wrap(
                                  children: <Widget>[
                                    IconButton(
                                        tooltip: "Pesquisar",
                                        splashRadius: 24,
                                        visualDensity: const VisualDensity(
                                            horizontal: -4.0, vertical: -4.0),
                                        padding: EdgeInsets.zero,
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.search,
                                          color: AppTheme.colors.icon,
                                        )),
                                    IconButton(
                                        tooltip: "Mais opções",
                                        splashRadius: 24,
                                        visualDensity: const VisualDensity(
                                            horizontal: -4.0, vertical: -4.0),
                                        padding: EdgeInsets.zero,
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.more_vert,
                                          color: AppTheme.colors.icon,
                                        )), // icon-2
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
