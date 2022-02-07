import 'package:flutter/material.dart';
import 'package:notes_ignite/core/core.dart';

class SwitchSettingsTileWidget extends StatefulWidget {
  final Function(bool) onChanged;
  final String title;
  final bool switchValue;
  final TextStyle style;
  final Widget leading;
  final bool hasDivider;
  const SwitchSettingsTileWidget({
    Key? key,
    required this.onChanged,
    required this.title,
    required this.switchValue,
    required this.style,
    required this.leading,
    this.hasDivider = true,
  }) : super(key: key);

  @override
  _SwitchSettingsTileWidgetState createState() =>
      _SwitchSettingsTileWidgetState();
}

class _SwitchSettingsTileWidgetState extends State<SwitchSettingsTileWidget> {
  bool switchValue = true;
  @override
  void initState() {
    switchValue = widget.switchValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          secondary: widget.leading,
          activeColor: AppTheme.colors.bodySwitchSettings,
          inactiveThumbColor: AppTheme.colors.bodyDesactiveSwitchSettings,
          title: Text(
            widget.title,
            style: widget.style,
          ),
          onChanged: (value) {
            switchValue = value;
            widget.onChanged(value);
            setState(() {});
          },
          value: switchValue,
        ),
        if (widget.hasDivider)
          Divider(
            color: AppTheme.colors.bodyDividerSettings,
            thickness: 1,
          ),
      ],
    );
  }
}
