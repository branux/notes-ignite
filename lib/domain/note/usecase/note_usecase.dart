import 'package:flutter/foundation.dart';
import 'package:notes_ignite/domain/login/model/user_model.dart';
import 'package:notes_ignite/domain/note/model/note_model.dart';

import '/domain/note/repository/note_repository.dart';

abstract class INoteUseCase {
  Future<bool> createNote({required NoteModel note});
  Future<NoteModel> readNote({required String key});
  Future<bool> updateNote({required NoteModel note});
  Future<bool> deleteNote({required String key});
  Future<List<NoteModel>> readAllNote({required UserModel user});
  Future<List<NoteModel>> createAllNote({required List<NoteModel> notes});
  Future<List<NoteModel>> updateAllNote({required List<NoteModel> notes});
  Future<List<String>> deleteAllNote({required UserModel user});
  void dispose();
}

class NoteUseCase implements INoteUseCase {
  final INoteRepository _repository;
  NoteUseCase({INoteRepository? repository})
      : _repository = repository ?? NoteRepository();

  @override
  Future<bool> createNote({required NoteModel note}) async {
    try {
      return await _repository.createNote(note: note);
    } catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    }
  }

  @override
  Future<NoteModel> readNote({required String key}) async {
    try {
      return await _repository.readNote(key: key);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> updateNote({required NoteModel note}) async {
    try {
      return await _repository.updateNote(note: note);
    } catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    }
  }

  @override
  Future<bool> deleteNote({required String key}) async {
    try {
      return await _repository.deleteNote(key: key);
    } catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    }
  }

  @override
  Future<List<NoteModel>> createAllNote(
      {required List<NoteModel> notes}) async {
    List<NoteModel> listNotes = [];
    try {
      for (NoteModel note in notes) {
        bool isCreated = await _repository.createNote(note: note);
        if (isCreated) listNotes.add(note);
      }
      return listNotes;
    } catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    }
  }

  @override
  Future<List<NoteModel>> readAllNote({required UserModel user}) async {
    List<NoteModel> listNote = [];
    try {
      List<String> keysList = await _repository.keys(user: user);
      for (String key in keysList) {
        listNote.add(await _repository.readNote(key: key));
      }
      listNote.sort((a, b) {
        return -a.data.compareTo(b.data);
      });
      return listNote;
    } catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    }
  }

  @override
  Future<List<NoteModel>> updateAllNote(
      {required List<NoteModel> notes}) async {
    List<NoteModel> listNotes = [];
    try {
      for (NoteModel note in notes) {
        bool isUpdated = await _repository.updateNote(note: note);
        if (isUpdated) listNotes.add(note);
      }
      return listNotes;
    } catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    }
  }

  @override
  Future<List<String>> deleteAllNote({required UserModel user}) async {
    List<String> listId = [];
    try {
      List<String> keysList = await _repository.keys(user: user);
      for (String key in keysList) {
        bool isDelete = await _repository.deleteNote(key: key);
        if (isDelete) listId.add(key);
      }
      return listId;
    } catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    }
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
