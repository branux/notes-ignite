import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:notes_ignite/domain/note/model/note_model.dart';
import 'package:notes_ignite/domain/note/repository/note_repository.dart';
import 'package:notes_ignite/modules/note/widgets/alert_dialog_note/alert_dialog_note_widget.dart';
import 'package:uuid/uuid.dart';

part 'note_controller.g.dart';

class NoteController extends _NoteControllerBase with _$NoteController {
  NoteController() {}
}

abstract class _NoteControllerBase with Store {
  NoteRepository repository = NoteRepository();

  @observable
  NoteModel note = NoteModel.init();

  void titleSaved(String? title) => note = note.copyWith(title: title);

  void textSaved(String? text) => note = note.copyWith(text: text);

  void popController(BuildContext context) {
    Navigator.pop(context, note.id.isEmpty ? null : note);
  }

  @action
  void createNote(GlobalKey<FormState> formKey, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        bool isNew = note.id.isEmpty;
        formKey.currentState!.save();
        note = note.copyWith(data: DateTime.now());
        note = isNew ? note.copyWith(id: "note" + const Uuid().v4()) : note;
        bool isCreated = await repository.createNote(note: note);
        if (isCreated) {
          snackBar(
            context,
            isNew ? "Foi salvo com sucesso!" : "Foi editado com sucesso!",
            Colors.green,
          );
        } else {
          snackBar(
            context,
            isNew
                ? "Não foi salvo com sucesso!"
                : "Não foi editado com sucesso!",
            Colors.red,
          );
        }
      } catch (e) {
        snackBar(
          context,
          "Erro ao salvar!",
          Colors.red,
        );
      }
    } else {
      print("Not Validated");
    }
  }

  @action
  void modifyCurrentColor(Color color) =>
      note = note.copyWith(background: color);

  @action
  void modifyDropdownvalue(String? value) =>
      note = note.copyWith(important: value);

  void snackBar(BuildContext context, String text, Color color) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      duration: const Duration(seconds: 3),
      content: Text(text,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white)),
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
