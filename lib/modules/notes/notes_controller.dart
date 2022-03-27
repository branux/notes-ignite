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

  @observable
  ObservableList<NoteModel> notes = ObservableList<NoteModel>();

  @action
  Future<void> modifyState(NotesState stateModify) async => state = stateModify;

  @action
  Future<void> showListNotes({
    required UserModel user,
    required Function(List<NoteModel>) addNotes,
  }) async {
    try {
      await modifyState(NotesStateLoading());
      List<NoteModel> listNotes = await _noteUseCase.readAllNote(user: user);
      await modifyState(NotesStateSuccess(
          message: "Lista carregada com sucesso", result: listNotes));
      await addNotes(listNotes);
    } catch (e) {
      await modifyState(NotesStateFailure(message: e.toString()));
    }
  }

  @action
  Future<void> onDeleted(String key, Function onAnimationDeletion) async {
    try {
      await modifyState(NotesStateLoading());
      final count = await _noteUseCase.deleteNote(key: key);
      await onAnimationDeletion();
      await modifyState(NotesStateSuccess(
          message: I18nConst.deletedItemSuccess, result: count));
    } catch (e) {
      await modifyState(NotesStateFailure(message: e.toString()));
    }
  }

  @action
  Future<bool> confirmDismiss(String key) async {
    try {
      await modifyState(NotesStateLoading());
      final count = await _noteUseCase.deleteNote(key: key);
      await modifyState(NotesStateSuccess(
          message: I18nConst.deletedItemSuccess, result: count));
      return true;
    } catch (e) {
      await modifyState(
          NotesStateFailure(message: I18nConst.deletedItemFailed));
      return false;
    }
  }

  @action
  Future<void> signOutGoogle(VoidCallback navigation) async {
    try {
      await modifyState(NotesStateLoading());
      final isLogout = await _loginUseCase.signOutGoogle();
      await modifyState(NotesStateSuccess(
          message: "Você foi deslogado com sucesso!", result: isLogout));
      navigation();
    } catch (e) {
      await modifyState(NotesStateFailure(message: e.toString()));
    }
  }

  Future<void> addNotes(
    List<NoteModel> listNotes,
    GlobalKey<AnimatedListState> _listKey,
  ) async {
    notes.insertAll(0, listNotes);
    for (int offset = 0; offset < listNotes.length; offset++) {
      int timeMiliseconds = 1000;
      if (_listKey.currentState != null) {
        _listKey.currentState!.insertItem(0 + offset,
            duration: Duration(milliseconds: timeMiliseconds));
      }
    }
  }

  Future<void> onAnimationDeletion(int index,
      GlobalKey<AnimatedListState> _listKey, BuildContext context) async {
    NoteModel removedItem = notes.removeAt(index);
    AnimatedListRemovedItemBuilder builder;
    builder = (context, animation) => removeItem(removedItem, animation, index);

    _listKey.currentState!.removeItem(index, builder,
        duration: const Duration(milliseconds: 300));
  }

  Future<void> onEdit(
      {required BuildContext context,
      required NoteModel note,
      required UserModel user,
      required int index}) async {
    final noteModel = await Navigator.pushNamed(context, RouterClass.note,
        arguments: {'user': user, 'note': note});

    if (noteModel is NoteModel) {
      notes[index] = noteModel.copyWith();
    }
  }

  Future<void> onCreated(
      {required BuildContext context,
      required UserModel user,
      required GlobalKey<AnimatedListState> key}) async {
    final noteModel = await Navigator.pushNamed(context, RouterClass.note,
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

  void onDismissed(
    int index,
    BuildContext context,
    GlobalKey<AnimatedListState> _listKey,
  ) {
    notes.removeAt(index);
    _listKey.currentState!
        .removeItem(index, (context, animation) => Container());
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

  Map<String, String> getListMenu() => {
        "menuAbout": I18nConst.menuAbout,
        "menuSettings": I18nConst.menuSettings,
        "menuLogout": I18nConst.menuLogout,
      };

  void navigationToLogin(BuildContext context) =>
      Navigator.pushReplacementNamed(context, RouterClass.login);

  void selectListMenu(
      BuildContext context, String value, UserModel user) async {
    if (value == "menuAbout") {
      showDialogAbout(context);
    } else if (value == "menuLogout") {
      signOutGoogle(() => navigationToLogin(context));
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

  void autoRun(BuildContext context) {
    autorun((_) {
      if (state is NotesStateFailure) {
        snackBar(context, (state as NotesStateFailure).message, Colors.red);
      } else if (state is NotesStateSuccess) {
        snackBar(context, (state as NotesStateSuccess).message, Colors.green);
      }
    });
  }

  void dispose() {
    _loginUseCase.dispose();
    _noteUseCase.dispose();
  }
}
