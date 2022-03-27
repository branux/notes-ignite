abstract class NotesState {}

class NotesStateEmpty extends NotesState {}

class NotesStateLoading extends NotesState {}

class NotesStateFailure extends NotesState {
  final String message;
  NotesStateFailure({
    required this.message,
  });
}

class NotesStateSuccess extends NotesState {
  final String message;
  final Object result;
  NotesStateSuccess({
    required this.message,
    required this.result,
  });
}
