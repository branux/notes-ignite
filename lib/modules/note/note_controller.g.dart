// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NoteController on _NoteControllerBase, Store {
  final _$noteAtom = Atom(name: '_NoteControllerBase.note');

  @override
  NoteModel get note {
    _$noteAtom.reportRead();
    return super.note;
  }

  @override
  set note(NoteModel value) {
    _$noteAtom.reportWrite(value, super.note, () {
      super.note = value;
    });
  }

  final _$stateAtom = Atom(name: '_NoteControllerBase.state');

  @override
  NoteState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(NoteState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$modifyStateAsyncAction =
      AsyncAction('_NoteControllerBase.modifyState');

  @override
  Future<void> modifyState(NoteState stateModify) {
    return _$modifyStateAsyncAction.run(() => super.modifyState(stateModify));
  }

  final _$createNoteAsyncAction = AsyncAction('_NoteControllerBase.createNote');

  @override
  Future<void> createNote(UserModel user, NoteModel noteCreate) {
    return _$createNoteAsyncAction
        .run(() => super.createNote(user, noteCreate));
  }

  final _$updateNoteAsyncAction = AsyncAction('_NoteControllerBase.updateNote');

  @override
  Future<void> updateNote(UserModel user, NoteModel noteUpdate) {
    return _$updateNoteAsyncAction
        .run(() => super.updateNote(user, noteUpdate));
  }

  final _$modifyNoteAsyncAction = AsyncAction('_NoteControllerBase.modifyNote');

  @override
  Future<void> modifyNote(bool isValid, UserModel user) {
    return _$modifyNoteAsyncAction.run(() => super.modifyNote(isValid, user));
  }

  final _$_NoteControllerBaseActionController =
      ActionController(name: '_NoteControllerBase');

  @override
  void modifyCurrentColor(Color color) {
    final _$actionInfo = _$_NoteControllerBaseActionController.startAction(
        name: '_NoteControllerBase.modifyCurrentColor');
    try {
      return super.modifyCurrentColor(color);
    } finally {
      _$_NoteControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void modifyDropdownvalue(String? value) {
    final _$actionInfo = _$_NoteControllerBaseActionController.startAction(
        name: '_NoteControllerBase.modifyDropdownvalue');
    try {
      return super.modifyDropdownvalue(value);
    } finally {
      _$_NoteControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
note: ${note},
state: ${state}
    ''';
  }
}
