import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:notes_ignite/core/core.dart';
import 'package:notes_ignite/domain/login/model/user_model.dart';
import 'package:notes_ignite/domain/note/model/note_model.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';
import 'package:notes_ignite/modules/note/widgets/alert_dialog_note/alert_dialog_note_widget.dart';
import 'package:uuid/uuid.dart';

import '../../domain/note/usecase/note_usecase.dart';
import 'note_state.dart';

part 'note_controller.g.dart';

class NoteController extends _NoteControllerBase with _$NoteController {
  NoteController({INoteUseCase? useCase}) {
    _useCase = useCase ?? NoteUseCase();
  }
}

abstract class _NoteControllerBase with Store {
  late INoteUseCase _useCase;

  @observable
  NoteModel note = NoteModel.init();

  @observable
  NoteState state = NoteStateEmpty();

  NoteModel noteToUpdateNotesPage = NoteModel.init();

  Color lastColor = AppTheme.colors.colorsPicker.first;

  void titleSaved(String? title) => note = note.copyWith(title: title);

  void textSaved(String? text) => note = note.copyWith(text: text);

  void popController(BuildContext context) {
    Navigator.pop(context,
        noteToUpdateNotesPage.id.isEmpty ? null : noteToUpdateNotesPage);
  }

  void lastColorSaved() => lastColor = note.background;

  bool isNew() => note.id.isEmpty;

  @action
  void modifyCurrentColor(Color color) {
    lastColor = note.background;
    note = note.copyWith(background: color);
  }

  @action
  void modifyDropdownvalue(String? value) =>
      note = note.copyWith(important: value);

  @action
  Future<void> modifyState(NoteState stateModify) async => state = stateModify;

  @action
  Future<void> createNote(UserModel user, NoteModel noteCreate) async {
    try {
      await modifyState(NoteStateLoading());
      final note = await _useCase.createNote(note: noteCreate);
      await modifyState(
          NoteStateSuccess(message: I18nConst.saveSuccess, result: note));
      noteToUpdateNotesPage = note.copyWith();
    } catch (e) {
      await modifyState(NoteStateFailure(message: e.toString()));
    }
  }

  @action
  Future<void> updateNote(UserModel user, NoteModel noteUpdate) async {
    try {
      await modifyState(NoteStateLoading());
      final count = await _useCase.updateNote(note: noteUpdate);
      await modifyState(
          NoteStateSuccess(message: I18nConst.editSuccess, result: count));
      noteToUpdateNotesPage = note.copyWith();
    } catch (e) {
      await modifyState(NoteStateFailure(message: e.toString()));
    }
  }

  @action
  Future<void> modifyNote(bool isValid, UserModel user) async {
    bool isNew = note.id.isEmpty;
    if (isValid) {
      if (isNew) {
        note = note.copyWith(
            id: "note" + user.id + const Uuid().v4(),
            data: DateTime.now(),
            idUser: user.id);
        await createNote(user, note);
      } else {
        await updateNote(user, note);
      }
    }
  }

  Future<bool> isValid(bool validate, VoidCallback save) async {
    await modifyState(NoteStateLoading());
    if (validate) {
      save();
      await modifyState(NoteStateEmpty());
      return true;
    } else {
      await modifyState(NoteStateFailure(message: I18nConst.formDataValid));
      return false;
    }
  }

  void snackBar(BuildContext context, String text, Color color) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      duration: const Duration(seconds: 3),
      content: Text(text,
          textAlign: TextAlign.center, style: AppTheme.textStyles.textSnackBar),
    ));
  }

  void autoRun(BuildContext context) {
    autorun((_) {
      if (state is NoteStateFailure) {
        snackBar(context, (state as NoteStateFailure).message, Colors.red);
      } else if (state is NoteStateSuccess) {
        snackBar(context, (state as NoteStateSuccess).message, Colors.green);
      }
    });
  }

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
