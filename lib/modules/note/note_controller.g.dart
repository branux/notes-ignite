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
note: ${note}
    ''';
  }
}
