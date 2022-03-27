abstract class NoteState {}

class NoteStateEmpty extends NoteState {}

class NoteStateLoading extends NoteState {}

class NoteStateFailure extends NoteState {
  final String message;
  NoteStateFailure({
    required this.message,
  });
}

class NoteStateSuccess extends NoteState {
  final String message;
  final Object result;
  NoteStateSuccess({
    required this.message,
    required this.result,
  });
}
