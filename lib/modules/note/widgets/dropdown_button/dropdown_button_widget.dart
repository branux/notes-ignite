import 'package:flutter/material.dart';

import '/core/core.dart';

class DropdownButtonWidget<T> extends StatelessWidget {
  final T dropdownvalue;
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?)? onChanged;
  const DropdownButtonWidget({
    Key? key,
    required this.dropdownvalue,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isExpanded: true,
      isDense: true,
      iconSize: 28,
      value: dropdownvalue,
      underline: Container(),
      style: AppTheme.textStyles.textSelect,
      dropdownColor: AppTheme.colors.background,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: items,
      onChanged: onChanged,
    );
  }
}
