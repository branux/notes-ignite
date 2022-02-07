import 'package:flutter/foundation.dart';
import 'package:notes_ignite/domain/login/model/user_model.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/note_model.dart';

class NoteRepository {
  Future<bool> createNote({required NoteModel note}) async {
    try {
      final SharedPreferences instance = await SharedPreferences.getInstance();
      return await instance.setString(note.id, note.toJson());
    } catch (e) {
      if (kDebugMode) print(e);
      return false;
    }
  }

  Future<NoteModel> readNote({required String key}) async {
    try {
      final SharedPreferences instance = await SharedPreferences.getInstance();
      String? response = instance.getString(key);
      return response == null
          ? throw I18nConst.notLocalizedNote
          : NoteModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateNote({required NoteModel note}) async {
    try {
      final SharedPreferences instance = await SharedPreferences.getInstance();
      return await instance.setString(note.id, note.toJson());
    } catch (e) {
      if (kDebugMode) print(e);
      return false;
    }
  }

  Future<bool> deleteNote({required String key}) async {
    try {
      final SharedPreferences instance = await SharedPreferences.getInstance();
      return await instance.remove(key);
    } catch (e) {
      if (kDebugMode) print(e);
      return false;
    }
  }

  Future<List<String>> keys({required UserModel user}) async {
    try {
      final SharedPreferences instance = await SharedPreferences.getInstance();
      Set<String> keys = instance.getKeys();
      List<String> keysList = [];
      for (String key in keys) {
        if (key.contains("note") && key.contains(user.id)) keysList.add(key);
      }
      return keysList;
    } catch (e) {
      return [];
    }
  }

  void dispose() {}
}
