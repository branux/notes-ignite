import 'package:flutter/material.dart';

import '/core/core.dart';

class DropdownButtonWidget<T> extends StatefulWidget {
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
  State<DropdownButtonWidget<T>> createState() =>
      _DropdownButtonWidgetState<T>();
}

class _DropdownButtonWidgetState<T> extends State<DropdownButtonWidget<T>> {
  @override
  Widget build(BuildContext context) {
    if (mounted) {
      return DropdownButton(
        isExpanded: true,
        iconSize: 28,
        value: widget.dropdownvalue,
        underline: Container(),
        style: AppTheme.textStyles.textSelect,
        dropdownColor: AppTheme.colors.background,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: widget.items,
        onChanged: widget.onChanged,
      );
    }
    return Container();
  }
}
