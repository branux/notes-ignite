import 'package:flutter/material.dart';
import 'package:notes_ignite/core/core.dart';

class MenuAppBarWidget extends StatefulWidget {
  final List<String> options;
  final Function(String) onSelected;
  const MenuAppBarWidget({
    Key? key,
    required this.options,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<MenuAppBarWidget> createState() => _MenuAppBarWidgetState();
}

class _MenuAppBarWidgetState extends State<MenuAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(36),
      child: Material(
        color: Colors.transparent,
        child: PopupMenuButton<String>(
          color: AppTheme.colors.icon,
          icon: Icon(
            Icons.more_vert_rounded,
            color: AppTheme.colors.icon,
          ),
          onSelected: widget.onSelected,
          itemBuilder: (BuildContext context) {
            return widget.options.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
