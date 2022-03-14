import 'package:flutter/material.dart';

import 'package:notes_ignite/core/core.dart';

import '../../../../../i18n/i18n_const.dart';

class MenuAppBarWidget extends StatefulWidget {
  final Map<String, String> options;
  final Function(String) onSelected;
  final double height;
  const MenuAppBarWidget({
    Key? key,
    required this.options,
    required this.onSelected,
    required this.height,
  }) : super(key: key);

  @override
  State<MenuAppBarWidget> createState() => _MenuAppBarWidgetState();
}

class _MenuAppBarWidgetState extends State<MenuAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.height),
      child: Material(
        color: Colors.transparent,
        child: PopupMenuButton<String>(
          tooltip: I18nConst.showMenu,
          color: AppTheme.colors.background,
          child: Padding(
            padding: EdgeInsets.all(widget.height / 3),
            child: Icon(
              Icons.more_vert_rounded,
              color: AppTheme.colors.icon,
              size: widget.height,
            ),
          ),
          onSelected: widget.onSelected,
          itemBuilder: (BuildContext context) {
            return widget.options.keys.map((key) {
              return PopupMenuItem<String>(
                height: AppTheme.textStyles.textSelect.fontSize! * 3,
                textStyle: AppTheme.textStyles.textSelect,
                value: key,
                child: Text(widget.options[key]!,
                    style: AppTheme.textStyles.textSelect),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
