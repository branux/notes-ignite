import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:notes_ignite/domain/login/model/user_model.dart';
import 'package:notes_ignite/domain/login/usecase/login_usecase.dart';
import 'package:notes_ignite/domain/note/model/importance_model.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';
import 'package:notes_ignite/shared/alert_dialog_about/alert_dialog_about.dart';
import 'package:share_plus/share_plus.dart';
import '../../shared/settings_widgets/cart_text_widget/card_text_widget.dart';
import '/domain/note/usecase/note_usecase.dart';
import '/domain/note/model/note_model.dart';
import '/modules/notes/notes_state.dart';
import '/core/core.dart';

import 'widgets/card_note/card_note_widget.dart';

part 'notes_controller.g.dart';

class NotesController extends _NotesControllerBase with _$NotesController {
  NotesController({ILoginUseCase? loginUseCase, INoteUseCase? noteUseCase}) {
    _loginUseCase = loginUseCase ?? LoginUseCase();
    _noteUseCase = noteUseCase ?? NoteUseCase();
  }
}

abstract class _NotesControllerBase with Store {
  late ILoginUseCase _loginUseCase;

  late INoteUseCase _noteUseCase;

  @observable
  NotesState state = NotesStateEmpty();

  ObservableList<NoteModel> notes = ObservableList<NoteModel>();

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
      List<NoteModel> listNotes = await _noteUseCase.readAllNote(user: user);
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
    bool deleted = await _noteUseCase.deleteNote(key: notes[index].id);
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
    bool deleted = await _noteUseCase.deleteNote(key: notes[index].id);
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
      await _loginUseCase.signOutGoogle();
      Navigator.pushReplacementNamed(context, RouterClass.login);
    } catch (e) {
      if (kDebugMode) {
        print("Erro pra sair" + e.toString());
      }
    }
  }

  Map<String, String> getListMenu() => {
        "menuAbout": I18nConst.menuAbout,
        "menuSettings": I18nConst.menuSettings,
        "menuLogout": I18nConst.menuLogout,
      };

  void selectListMenu(
      BuildContext context, String value, UserModel user) async {
    if (value == "menuAbout") {
      showDialogAbout(context);
    } else if (value == "menuLogout") {
      signOutGoogle(context);
    } else if (value == "menuSettings") {
      await Navigator.pushNamed(context, RouterClass.settings, arguments: user);
    }
  }

  void showDialogAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogAbout(
          title: 'Sobre',
          back: 'Sair',
          onPress: () => Navigator.pop(context),
          children: const [
            CardTextWidget(
              title: "Desenvolvido por",
              subtitle: "Uai Rodrigo Dev",
              column: false,
              textAlign: TextAlign.right,
            ),
            CardTextWidget(
              title: "Instagram",
              subtitle: "@_rodmoraes",
              column: false,
              textAlign: TextAlign.right,
              icon: FontAwesomeIcons.instagram,
            ),
            CardTextWidget(
              title: "Linkedin",
              subtitle: "@rod-moraes",
              column: false,
              textAlign: TextAlign.right,
              icon: FontAwesomeIcons.linkedin,
            ),
            CardTextWidget(
              title: "Github",
              subtitle: "@rod-moraes",
              column: false,
              textAlign: TextAlign.right,
              icon: FontAwesomeIcons.github,
            ),
          ],
        );
      },
    );
  }

  void dispose() {
    _loginUseCase.dispose();
    _noteUseCase.dispose();
  }
}
