import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:notes_ignite/domain/login/model/user_model.dart';
import 'package:notes_ignite/domain/login/usecase/login_usecase.dart';
import 'package:notes_ignite/domain/note/model/note_model.dart';
import 'package:notes_ignite/domain/note/usecase/note_usecase.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';
import 'package:notes_ignite/modules/notes/notes_controller.dart';
import 'package:notes_ignite/modules/notes/notes_state.dart';

class NoteUseCaseMock extends mocktail.Mock implements INoteUseCase {}

class LoginUseCaseMock extends mocktail.Mock implements ILoginUseCase {}

void main() {
  late NotesController controller;
  late INoteUseCase noteUseCase;
  late ILoginUseCase loginUseCase;
  late UserModel user;
  late NoteModel note;
  setUp(() {
    noteUseCase = NoteUseCaseMock();
    loginUseCase = LoginUseCaseMock();
    controller =
        NotesController(loginUseCase: loginUseCase, noteUseCase: noteUseCase);
    user = UserModel(
      name: "Usuário Teste",
      email: "usuario@teste.com.br",
      id: "1",
      photoUrl: 'teste.png',
    );
    note = NoteModel.init();
  });

  // showListNotes
  // onDeleted
  // confirmDismiss
  // signOutGoogle

  test('Testando showListNotes Success', () async {
    final states = <NotesState>[];
    mobx.autorun((_) {
      states.add(controller.state);
    });
    mocktail
        .when(noteUseCase)
        .calls(#readAllNote)
        .thenAnswer((_) => Future.value([note]));

    await controller.showListNotes(user: user, addNotes: (notes) {});
    expect(states[0], isInstanceOf<NotesStateEmpty>());
    expect(states[1], isInstanceOf<NotesStateLoading>());
    expect(states[2], isInstanceOf<NotesStateSuccess>());
    expect((controller.state as NotesStateSuccess).message,
        isInstanceOf<String>());
    expect((controller.state as NotesStateSuccess).message,
        "Lista carregada com sucesso");
    expect((controller.state as NotesStateSuccess).result,
        isInstanceOf<List<NoteModel>>());
    expect((controller.state as NotesStateSuccess).result, [note]);
  });

  test('Testando showListNotes Failure', () async {
    final states = <NotesState>[];
    mobx.autorun((_) {
      states.add(controller.state);
    });
    mocktail
        .when(noteUseCase)
        .calls(#readAllNote)
        .thenThrow(I18nConst.notLocalizedNote);

    await controller.showListNotes(user: user, addNotes: (notes) {});
    expect(states[0], isInstanceOf<NotesStateEmpty>());
    expect(states[1], isInstanceOf<NotesStateLoading>());
    expect(states[2], isInstanceOf<NotesStateFailure>());
    expect((controller.state as NotesStateFailure).message,
        isInstanceOf<String>());
    expect((controller.state as NotesStateFailure).message,
        I18nConst.notLocalizedNote);
  });

  test('Testando onDeleted note Success', () async {
    final states = <NotesState>[];
    mobx.autorun((_) {
      states.add(controller.state);
    });
    mocktail
        .when(noteUseCase)
        .calls(#deleteNote)
        .thenAnswer((_) => Future.value(1));

    await controller.onDeleted('key', () {});
    expect(states[0], isInstanceOf<NotesStateEmpty>());
    expect(states[1], isInstanceOf<NotesStateLoading>());
    expect(states[2], isInstanceOf<NotesStateSuccess>());
    expect((controller.state as NotesStateSuccess).message,
        isInstanceOf<String>());
    expect((controller.state as NotesStateSuccess).message,
        I18nConst.deletedItemSuccess);
    expect((controller.state as NotesStateSuccess).result, isInstanceOf<int>());
    expect((controller.state as NotesStateSuccess).result, 1);
  });

  test('Testando onDeleted note Failure', () async {
    final states = <NotesState>[];
    mobx.autorun((_) {
      states.add(controller.state);
    });
    mocktail
        .when(noteUseCase)
        .calls(#deleteNote)
        .thenThrow(I18nConst.deletedItemFailed);

    await controller.onDeleted('key', () {});
    expect(states[0], isInstanceOf<NotesStateEmpty>());
    expect(states[1], isInstanceOf<NotesStateLoading>());
    expect(states[2], isInstanceOf<NotesStateFailure>());
    expect((controller.state as NotesStateFailure).message,
        isInstanceOf<String>());
    expect((controller.state as NotesStateFailure).message,
        I18nConst.deletedItemFailed);
  });

  test('Testando confirmDismiss note Success', () async {
    final states = <NotesState>[];
    mobx.autorun((_) {
      states.add(controller.state);
    });
    mocktail
        .when(noteUseCase)
        .calls(#deleteNote)
        .thenAnswer((_) => Future.value(1));

    await controller.confirmDismiss('key');
    expect(states[0], isInstanceOf<NotesStateEmpty>());
    expect(states[1], isInstanceOf<NotesStateLoading>());
    expect(states[2], isInstanceOf<NotesStateSuccess>());
    expect((controller.state as NotesStateSuccess).message,
        isInstanceOf<String>());
    expect((controller.state as NotesStateSuccess).message,
        I18nConst.deletedItemSuccess);
    expect((controller.state as NotesStateSuccess).result, isInstanceOf<int>());
    expect((controller.state as NotesStateSuccess).result, 1);
  });

  test('Testando confirmDismiss note Failure', () async {
    final states = <NotesState>[];
    mobx.autorun((_) {
      states.add(controller.state);
    });
    mocktail
        .when(noteUseCase)
        .calls(#deleteNote)
        .thenThrow(I18nConst.deletedItemFailed);

    await controller.confirmDismiss('key');
    expect(states[0], isInstanceOf<NotesStateEmpty>());
    expect(states[1], isInstanceOf<NotesStateLoading>());
    expect(states[2], isInstanceOf<NotesStateFailure>());
    expect((controller.state as NotesStateFailure).message,
        isInstanceOf<String>());
    expect((controller.state as NotesStateFailure).message,
        I18nConst.deletedItemFailed);
  });

  test('Testando signOutGoogle Success', () async {
    final states = <NotesState>[];
    mobx.autorun((_) {
      states.add(controller.state);
    });
    mocktail
        .when(loginUseCase)
        .calls(#signOutGoogle)
        .thenAnswer((_) => Future.value(true));

    await controller.signOutGoogle(() {});
    expect(states[0], isInstanceOf<NotesStateEmpty>());
    expect(states[1], isInstanceOf<NotesStateLoading>());
    expect(states[2], isInstanceOf<NotesStateSuccess>());
    expect((controller.state as NotesStateSuccess).message,
        isInstanceOf<String>());
    expect((controller.state as NotesStateSuccess).message,
        "Você foi deslogado com sucesso!");
    expect(
        (controller.state as NotesStateSuccess).result, isInstanceOf<bool>());
    expect((controller.state as NotesStateSuccess).result, true);
  });

  test('Testando signOutGoogle Failure', () async {
    final states = <NotesState>[];
    mobx.autorun((_) {
      states.add(controller.state);
    });
    mocktail
        .when(loginUseCase)
        .calls(#signOutGoogle)
        .thenThrow(I18nConst.deletedItemFailed);

    await controller.signOutGoogle(() {});
    expect(states[0], isInstanceOf<NotesStateEmpty>());
    expect(states[1], isInstanceOf<NotesStateLoading>());
    expect(states[2], isInstanceOf<NotesStateFailure>());
    expect((controller.state as NotesStateFailure).message,
        isInstanceOf<String>());
    expect((controller.state as NotesStateFailure).message,
        I18nConst.deletedItemFailed);
  });
}
