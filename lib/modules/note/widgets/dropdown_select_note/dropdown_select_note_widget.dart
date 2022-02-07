import 'package:flutter/material.dart';
import 'package:notes_ignite/domain/note/model/importance_model.dart';

import '../dropdown_button/dropdown_button_widget.dart';
import '/core/core.dart';

class DropdownSelectNoteWidget extends StatelessWidget {
  final String dropdownvalueInitial;
  final bool expanded;
  final Function(String?) onChanged;
  const DropdownSelectNoteWidget({
    Key? key,
    required this.dropdownvalueInitial,
    this.expanded = false,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dropdownvalue = dropdownvalueInitial;
    Widget dropdownSelectNoteWidget = Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppTheme.colors.border, width: 1),
        ),
        padding: const EdgeInsets.only(left: 10, right: 5, top: 4, bottom: 4),
        child: DropdownButtonWidget(
          dropdownvalue: dropdownvalue,
          items: ImportanceModel.listImportances().map((ImportanceModel item) {
            print(item);
            return DropdownMenuItem(value: item.id, child: Text(item.text));
          }).toList(),
          onChanged: onChanged,
        ));
    return expanded
        ? Expanded(child: dropdownSelectNoteWidget)
        : dropdownSelectNoteWidget;
  }
}
