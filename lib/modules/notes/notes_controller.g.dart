// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotesController on _NotesControllerBase, Store {
  final _$stateAtom = Atom(name: '_NotesControllerBase.state');

  @override
  NotesState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(NotesState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$notesAtom = Atom(name: '_NotesControllerBase.notes');

  @override
  ObservableList<NoteModel> get notes {
    _$notesAtom.reportRead();
    return super.notes;
  }

  @override
  set notes(ObservableList<NoteModel> value) {
    _$notesAtom.reportWrite(value, super.notes, () {
      super.notes = value;
    });
  }

  final _$modifyStateAsyncAction =
      AsyncAction('_NotesControllerBase.modifyState');

  @override
  Future<void> modifyState(NotesState stateModify) {
    return _$modifyStateAsyncAction.run(() => super.modifyState(stateModify));
  }

  final _$showListNotesAsyncAction =
      AsyncAction('_NotesControllerBase.showListNotes');

  @override
  Future<void> showListNotes(
      {required UserModel user,
      required dynamic Function(List<NoteModel>) addNotes}) {
    return _$showListNotesAsyncAction
        .run(() => super.showListNotes(user: user, addNotes: addNotes));
  }

  final _$onDeletedAsyncAction = AsyncAction('_NotesControllerBase.onDeleted');

  @override
  Future<void> onDeleted(String key, Function onAnimationDeletion) {
    return _$onDeletedAsyncAction
        .run(() => super.onDeleted(key, onAnimationDeletion));
  }

  final _$confirmDismissAsyncAction =
      AsyncAction('_NotesControllerBase.confirmDismiss');

  @override
  Future<bool> confirmDismiss(String key) {
    return _$confirmDismissAsyncAction.run(() => super.confirmDismiss(key));
  }

  final _$signOutGoogleAsyncAction =
      AsyncAction('_NotesControllerBase.signOutGoogle');

  @override
  Future<void> signOutGoogle(VoidCallback navigation) {
    return _$signOutGoogleAsyncAction
        .run(() => super.signOutGoogle(navigation));
  }

  @override
  String toString() {
    return '''
state: ${state},
notes: ${notes}
    ''';
  }
}
