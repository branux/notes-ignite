import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:share_plus/share_plus.dart';
import '/domain/note/usecase/note_usecase.dart';
import '/domain/note/model/note_model.dart';
import '/modules/notes/notes_state.dart';
import '/core/core.dart';

import 'widgets/card_note/card_note_widget.dart';

part 'notes_controller.g.dart';

class NotesController extends _NotesControllerBase with _$NotesController {
  NotesController() {}
}

abstract class _NotesControllerBase with Store {
  @observable
  NotesState state = NotesStateEmpty();

  List<NoteModel> notes = <NoteModel>[];

  NoteUseCase useCase = NoteUseCase();

  Future<void> onEdit(
      {required BuildContext context,
      required NoteModel note,
      required int index}) async {
    var noteModel =
        await Navigator.pushNamed(context, RouterClass.note, arguments: note);

    if (noteModel is NoteModel) {
      notes[index] = noteModel.copyWith();
    }
  }

  Future<void> onCreated(
      {required BuildContext context,
      required GlobalKey<AnimatedListState> key}) async {
    var noteModel = await Navigator.pushNamed(context, RouterClass.note);

    if (noteModel is NoteModel) {
      notes.insert(0, noteModel);
      key.currentState!.insertItem(0);
    }
  }

  void onShared({
    required BuildContext context,
    required NoteModel note,
  }) async {
    await Share.share(
        "Titulo: ${note.title}\n${note.text}\n${note.important}\nCriado em: ${DateFormat('dd/MM/yyyy').format(note.data)}");
  }

  Future<void> showListNotes() async {
    try {
      state = NotesStateLoading();
      List<NoteModel> listNotes = await useCase.readAllNote();
      state = NotesStateSuccess(notes: listNotes);
      notes.addAll(listNotes);
    } catch (e) {
      state = NotesStateFailure(message: e.toString());
    }
  }

  Widget removeItem(NoteModel item, Animation<double> animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Column(
        children: [
          CardNoteWidget(key: UniqueKey(), note: item),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  Future<int> onDeleted(int index, GlobalKey<AnimatedListState> _listKey,
      BuildContext context) async {
    bool deleted = await useCase.deleteNote(key: notes[index].id);
    if (deleted) {
      NoteModel removedItem = notes.removeAt(index);
      AnimatedListRemovedItemBuilder builder;
      builder =
          (context, animation) => removeItem(removedItem, animation, index);

      _listKey.currentState!.removeItem(index, builder,
          duration: const Duration(milliseconds: 300));
      snackBar(context, "Item deletado com sucesso", Colors.green);
    } else {
      snackBar(context, "Item não foi deletado", Colors.red);
    }
    return index;
  }

  void onDismissed(
    int index,
    BuildContext context,
    GlobalKey<AnimatedListState> _listKey,
  ) {
    notes.removeAt(index);
    _listKey.currentState!
        .removeItem(index, (context, animation) => Container());
  }

  Future<bool> confirmDismiss(int index, BuildContext context) async {
    bool deleted = await useCase.deleteNote(key: notes[index].id);
    if (deleted) {
      snackBar(context, "Item deletado com sucesso", Colors.green);
    } else {
      snackBar(context, "Item não foi deletado", Colors.red);
    }
    return deleted;
  }

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
}
