import 'package:flutter/foundation.dart';
import 'package:notes_ignite/domain/note/model/note_model.dart';

import '/domain/note/repository/note_repository.dart';

class NoteUseCase {
  NoteRepository repository = NoteRepository();

  Future<bool> createNote({required NoteModel note}) async {
    try {
      return await repository.createNote(note: note);
    } catch (e) {
      if (kDebugMode) print(e);
      return false;
    }
  }

  Future<NoteModel> readNote({required String key}) async {
    try {
      return await repository.readNote(key: key);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateNote({required NoteModel note}) async {
    try {
      return await repository.updateNote(note: note);
    } catch (e) {
      if (kDebugMode) print(e);
      return false;
    }
  }

  Future<bool> deleteNote({required String key}) async {
    try {
      return await repository.deleteNote(key: key);
    } catch (e) {
      if (kDebugMode) print(e);
      return false;
    }
  }

  Future<List<NoteModel>> createAllNote(
      {required List<NoteModel> notes}) async {
    List<NoteModel> listNotes = [];
    try {
      for (NoteModel note in notes) {
        bool isCreated = await repository.createNote(note: note);
        if (isCreated) listNotes.add(note);
      }
      return listNotes;
    } catch (e) {
      if (kDebugMode) print(e);
      return listNotes;
    }
  }

  Future<List<NoteModel>> readAllNote() async {
    List<NoteModel> listNote = [];
    try {
      List<String> keysList = await repository.keys();
      for (String key in keysList) {
        listNote.add(await repository.readNote(key: key));
      }
      listNote.sort((a, b) {
        return -a.data.compareTo(b.data);
      });
      return listNote;
    } catch (e) {
      if (kDebugMode) print(e);
      return listNote;
    }
  }

  Future<List<NoteModel>> updateAllNote(
      {required List<NoteModel> notes}) async {
    List<NoteModel> listNotes = [];
    try {
      for (NoteModel note in notes) {
        bool isUpdated = await repository.updateNote(note: note);
        if (isUpdated) listNotes.add(note);
      }
      return listNotes;
    } catch (e) {
      if (kDebugMode) print(e);
      return listNotes;
    }
  }

  Future<List<String>> deleteAllNote() async {
    List<String> listId = [];
    try {
      List<String> keysList = await repository.keys();
      for (String key in keysList) {
        bool isDelete = await repository.deleteNote(key: key);
        if (isDelete) listId.add(key);
      }
      return listId;
    } catch (e) {
      if (kDebugMode) print(e);
      return listId;
    }
  }

  void dispose() {
    repository.dispose();
  }
}
