import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:notes_ignite/domain/login/model/user_model.dart';
import 'package:notes_ignite/domain/note/model/note_model.dart';
import 'package:notes_ignite/domain/note/usecase/note_usecase.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';
import 'package:notes_ignite/modules/note/note_controller.dart';
import 'package:notes_ignite/modules/note/note_state.dart';

class NoteUseCaseMock extends mocktail.Mock implements INoteUseCase {}

void main() {
  late NoteController controller;
  late INoteUseCase useCase;
  late UserModel user;
  late NoteModel note;
  setUp(() {
    useCase = NoteUseCaseMock();
    controller = NoteController(useCase: useCase);
    user = UserModel(
      name: "Usuário Teste",
      email: "usuario@teste.com.br",
      id: "1",
      photoUrl: 'teste.png',
    );
    note = NoteModel.init();
  });

  test('Testando created Note Success', () async {
    final states = <NoteState>[];
    mobx.autorun((_) {
      states.add(controller.state);
    });
    mocktail
        .when(useCase)
        .calls(#createNote)
        .thenAnswer((_) => Future.value(note));

    await controller.createNote(user, note);
    expect(states[0], isInstanceOf<NoteStateEmpty>());
    expect(states[1], isInstanceOf<NoteStateLoading>());
    expect(states[2], isInstanceOf<NoteStateSuccess>());
    expect(
        (controller.state as NoteStateSuccess).message, isInstanceOf<String>());
    expect(
        (controller.state as NoteStateSuccess).message, I18nConst.saveSuccess);
    expect((controller.state as NoteStateSuccess).result,
        isInstanceOf<NoteModel>());
    expect((controller.state as NoteStateSuccess).result, note);
  });

  test('Testando created Note Failure', () async {
    final states = <NoteState>[];
    mobx.autorun((_) {
      states.add(controller.state);
    });
    mocktail.when(useCase).calls(#createNote).thenThrow(I18nConst.saveFailed);

    await controller.createNote(user, note);
    expect(states[0], isInstanceOf<NoteStateEmpty>());
    expect(states[1], isInstanceOf<NoteStateLoading>());
    expect(states[2], isInstanceOf<NoteStateFailure>());
    expect(
        (controller.state as NoteStateFailure).message, isInstanceOf<String>());
    expect(
        (controller.state as NoteStateFailure).message, I18nConst.saveFailed);
  });

  test('Testando update Note Success', () async {
    final states = <NoteState>[];
    mobx.autorun((_) {
      states.add(controller.state);
    });
    mocktail
        .when(useCase)
        .calls(#updateNote)
        .thenAnswer((_) => Future.value(1));

    await controller.updateNote(user, note);

    expect(states[0], isInstanceOf<NoteStateEmpty>());
    expect(states[1], isInstanceOf<NoteStateLoading>());
    expect(states[2], isInstanceOf<NoteStateSuccess>());
    expect(
        (controller.state as NoteStateSuccess).message, isInstanceOf<String>());
    expect(
        (controller.state as NoteStateSuccess).message, I18nConst.editSuccess);
    expect((controller.state as NoteStateSuccess).result, isInstanceOf<int>());
    expect((controller.state as NoteStateSuccess).result, 1);
  });

  test('Testando update Note Failure', () async {
    final states = <NoteState>[];
    mobx.autorun((_) {
      states.add(controller.state);
    });
    mocktail.when(useCase).calls(#updateNote).thenThrow(I18nConst.editFailed);

    await controller.updateNote(user, note);
    expect(states[0], isInstanceOf<NoteStateEmpty>());
    expect(states[1], isInstanceOf<NoteStateLoading>());
    expect(states[2], isInstanceOf<NoteStateFailure>());
    expect(
        (controller.state as NoteStateFailure).message, isInstanceOf<String>());
    expect(
        (controller.state as NoteStateFailure).message, I18nConst.editFailed);
  });

  test('Testando form isValid Valid', () async {
    final states = <NoteState>[];
    mobx.autorun((_) {
      states.add(controller.state);
    });
    await controller.isValid(true, () {});
    expect(states[0], isInstanceOf<NoteStateEmpty>());
    expect(states[1], isInstanceOf<NoteStateLoading>());
    expect(states[2], isInstanceOf<NoteStateEmpty>());
  });

  test('Testando form isValid invalid', () async {
    final states = <NoteState>[];
    mobx.autorun((_) {
      states.add(controller.state);
    });
    await controller.isValid(false, () {});
    expect(states[0], isInstanceOf<NoteStateEmpty>());
    expect(states[1], isInstanceOf<NoteStateLoading>());
    expect(states[2], isInstanceOf<NoteStateFailure>());
    expect(
        (controller.state as NoteStateFailure).message, isInstanceOf<String>());
    expect((controller.state as NoteStateFailure).message,
        "Dados não estão validos");
  });
}
