import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:notes_ignite/core/core.dart';
import 'package:notes_ignite/domain/login/model/user_model.dart';
import 'package:notes_ignite/domain/note/model/note_model.dart';
import 'package:notes_ignite/domain/note/repository/note_repository.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';
import 'package:notes_ignite/modules/note/widgets/alert_dialog_note/alert_dialog_note_widget.dart';
import 'package:uuid/uuid.dart';

part 'note_controller.g.dart';

class NoteController extends _NoteControllerBase with _$NoteController {
  NoteController({INoteRepository? repository}) {
    _repository = repository ?? NoteRepository();
  }
}

abstract class _NoteControllerBase with Store {
  late INoteRepository _repository;

  @observable
  NoteModel note = NoteModel.init();

  NoteModel noteToUpdateNotesPage = NoteModel.init();

  Color lastColor = AppTheme.colors.colorsPicker.first;

  void titleSaved(String? title) => note = note.copyWith(title: title);

  void textSaved(String? text) => note = note.copyWith(text: text);

  void popController(BuildContext context) {
    Navigator.pop(context,
        noteToUpdateNotesPage.id.isEmpty ? null : noteToUpdateNotesPage);
  }

  void lastColorSaved() => lastColor = note.background;

  @action
  Future<void> modifyNote(GlobalKey<FormState> formKey, BuildContext context,
      UserModel user) async {
    if (formKey.currentState!.validate()) {
      bool isNew = note.id.isEmpty;
      formKey.currentState!.save();

      try {
        bool isCreated = false;
        if (isNew) {
          note = note.copyWith(
            id: "note" + user.id + const Uuid().v4(),
            data: DateTime.now(),
            idUser: user.id,
          );
          isCreated = await _repository.createNote(note: note);
        } else {
          isCreated = await _repository.updateNote(note: note);
        }
        if (isCreated) {
          noteToUpdateNotesPage = note.copyWith();
          snackBar(
            context,
            isNew ? I18nConst.saveSuccess : I18nConst.editSuccess,
            Colors.green,
          );
        } else {
          snackBar(
            context,
            isNew ? I18nConst.saveFailed : I18nConst.editFailed,
            Colors.red,
          );
        }
      } catch (e) {
        snackBar(
          context,
          isNew ? I18nConst.saveFailed : I18nConst.editFailed,
          Colors.red,
        );
      }
    } else {
      if (kDebugMode) {
        print("Not Validated");
      }
    }
  }

  @action
  void modifyCurrentColor(Color color) {
    lastColor = note.background;
    note = note.copyWith(background: color);
  }

  @action
  void modifyDropdownvalue(String? value) =>
      note = note.copyWith(important: value);

  void snackBar(BuildContext context, String text, Color color) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      duration: const Duration(seconds: 3),
      content: Text(text,
          textAlign: TextAlign.center, style: AppTheme.textStyles.textSnackBar),
    ));
  }

// raise the [showDialog] widget
  void showDialogNote(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogNoteWidget(
          note: note,
          onPressed: (Color pickerColor) {
            modifyCurrentColor(pickerColor);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
