import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:notes_ignite/core/core.dart';
import 'package:notes_ignite/domain/note/model/note_model.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';

class AlertDialogNoteWidget extends StatelessWidget {
  final void Function(Color) onPressed;
  final NoteModel note;
  const AlertDialogNoteWidget({
    Key? key,
    required this.onPressed,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    Color pickerColor = note.background;
    return AlertDialog(
      backgroundColor: AppTheme.colors.background,
      scrollable: true,
      title: Text(
        I18nConst.chooseColor,
        style: AppTheme.textStyles.textAlertDialog,
      ),
      content: SizedBox(
        width: 100,
        height: 168,
        child: BlockPicker(
          pickerColor: note.background,
          availableColors: AppTheme.colors.colorsPicker,
          onColorChanged: (color) => pickerColor = color,
          layoutBuilder: (context, colors, child) => GridView.count(
            crossAxisCount: orientation == Orientation.portrait ? 4 : 6,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            children: [for (Color color in colors) child(color)],
          ),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(AppTheme.colors.background),
            side: MaterialStateProperty.all<BorderSide>(
                BorderSide(color: AppTheme.colors.border, width: 1)),
          ),
          child: Text(
            I18nConst.modify,
            style: AppTheme.textStyles.textSimple.copyWith(fontSize: 14),
          ),
          onPressed: () => onPressed(pickerColor),
        ),
      ],
    );
  }
}
