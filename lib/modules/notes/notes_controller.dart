import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:notes_ignite/domain/login/model/user_model.dart';
import 'package:notes_ignite/domain/login/usecase/login_usecase.dart';
import 'package:notes_ignite/domain/note/model/importance_model.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';
import 'package:share_plus/share_plus.dart';
import '/domain/note/usecase/note_usecase.dart';
import '/domain/note/model/note_model.dart';
import '/modules/notes/notes_state.dart';
import '/core/core.dart';

import 'widgets/card_note/card_note_widget.dart';

part 'notes_controller.g.dart';

class NotesController extends _NotesControllerBase with _$NotesController {
  NotesController();
}

abstract class _NotesControllerBase with Store {
  @observable
  NotesState state = NotesStateEmpty();

  LoginUseCase loginUseCase = LoginUseCaseImpl();

  List<NoteModel> notes = <NoteModel>[];

  NoteUseCase noteUseCase = NoteUseCase();

  Future<void> onEdit(
      {required BuildContext context,
      required NoteModel note,
      required UserModel user,
      required int index}) async {
    var noteModel = await Navigator.pushNamed(context, RouterClass.note,
        arguments: {'user': user, 'note': note});

    if (noteModel is NoteModel) {
      notes[index] = noteModel.copyWith();
    }
  }

  Future<void> onCreated(
      {required BuildContext context,
      required UserModel user,
      required GlobalKey<AnimatedListState> key}) async {
    var noteModel = await Navigator.pushNamed(context, RouterClass.note,
        arguments: {'user': user});

    if (noteModel is NoteModel) {
      notes.insert(0, noteModel);
      key.currentState!.insertItem(0);
    }
  }

  void onShared({
    required BuildContext context,
    required NoteModel note,
  }) async {
    await Share.share("${I18nConst.title}: "
        "${note.title}\n"
        "${note.text}\n"
        "${ImportanceModel.textImportance(note.important)}\n"
        "${I18nConst.createIn}: "
        "${DateFormat('dd/MM/yyyy').format(note.data)}");
  }

  Future<void> showListNotes({required UserModel user}) async {
    try {
      state = NotesStateLoading();
      List<NoteModel> listNotes = await noteUseCase.readAllNote(user: user);
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
    bool deleted = await noteUseCase.deleteNote(key: notes[index].id);
    if (deleted) {
      NoteModel removedItem = notes.removeAt(index);
      AnimatedListRemovedItemBuilder builder;
      builder =
          (context, animation) => removeItem(removedItem, animation, index);

      _listKey.currentState!.removeItem(index, builder,
          duration: const Duration(milliseconds: 300));
      snackBar(context, I18nConst.deletedItemSuccess, Colors.green);
    } else {
      snackBar(context, I18nConst.deletedItemFailed, Colors.red);
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
    bool deleted = await noteUseCase.deleteNote(key: notes[index].id);
    if (deleted) {
      snackBar(context, I18nConst.deletedItemSuccess, Colors.green);
    } else {
      snackBar(context, I18nConst.deletedItemFailed, Colors.red);
    }
    return deleted;
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

  Future<void> signOutGoogle(BuildContext context) async {
    try {
      print("teste");
      await loginUseCase.signOutGoogle();
      Navigator.pushReplacementNamed(context, RouterClass.login);
    } catch (e) {
      print("Erro pra sair" + e.toString());
    }
  }

  List<String> getListMenu() => [
        I18nConst.menuAbout,
        I18nConst.menuSettings,
        I18nConst.menuLogout,
      ];

  void selectListMenu(BuildContext context, String value, UserModel user) {
    if (value == I18nConst.menuAbout) {
    } else if (value == I18nConst.menuLogout) {
      signOutGoogle(context);
    } else if (value == I18nConst.menuSettings) {
      Navigator.pushNamed(context, RouterClass.settings, arguments: user);
    }
  }

  void dispose() {
    loginUseCase.dispose();
    noteUseCase.dispose();
  }
}
