//LOGIN ABSTRATA PARA GENERALIZAR
import '/domain/note/model/note_model.dart';

abstract class NotesState {}

//LOGIN VAZIA QUANDO INICIA
class NotesStateEmpty extends NotesState {}

//LOGIN LOADING QUANDO INICIA O CARREGAMENTO
class NotesStateLoading extends NotesState {}

//LOGIN FALHA QUANDO FALHA O CARREGAMENTO
class NotesStateFailure extends NotesState {
  final String message;
  NotesStateFailure({
    required this.message,
  });
}

//LOGIN SUCESSO QUANDO DA SUCESSO O CARREGAMENTO
class NotesStateSuccess extends NotesState {
  final List<NoteModel> notes;
  NotesStateSuccess({
    required this.notes,
  });
}
