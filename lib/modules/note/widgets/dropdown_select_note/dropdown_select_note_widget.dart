import 'package:flutter/material.dart';
import 'package:notes_ignite/domain/note/model/importance_model.dart';
import 'package:sizer/sizer.dart';

import '../dropdown_button/dropdown_button_widget.dart';
import '/core/core.dart';

class DropdownSelectNoteWidget extends StatefulWidget {
  final String dropdownvalueInitial;
  final bool expanded;
  final void Function(String?) onChanged;
  const DropdownSelectNoteWidget({
    Key? key,
    required this.dropdownvalueInitial,
    this.expanded = false,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<DropdownSelectNoteWidget> createState() =>
      _DropdownSelectNoteWidgetState();
}

class _DropdownSelectNoteWidgetState extends State<DropdownSelectNoteWidget> {
  @override
  Widget build(BuildContext context) {
    double borderWidth = 0.3.w;
    double borderRadius = 1.w;
    String dropdownvalue = widget.dropdownvalueInitial;
    Widget dropdownSelectNoteWidget = Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: AppTheme.colors.border, width: borderWidth),
        ),
        padding: const EdgeInsets.only(left: 10, right: 5),
        alignment: Alignment.center,
        child: DropdownButtonWidget(
          dropdownvalue: dropdownvalue,
          items: ImportanceModel.listImportances().map((ImportanceModel item) {
            return DropdownMenuItem(value: item.id, child: Text(item.text));
          }).toList(),
          onChanged: (String? value) {
            widget.onChanged(value);
          },
        ));
    return widget.expanded
        ? Expanded(child: dropdownSelectNoteWidget)
        : dropdownSelectNoteWidget;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
