import 'package:flutter/foundation.dart';
import 'package:notes_ignite/domain/login/model/user_model.dart';
import 'package:notes_ignite/i18n/i18n_const.dart';
import 'package:sqflite/sqflite.dart';

import '../model/note_model.dart';

abstract class INoteRepository {
  Future<bool> createNote({required NoteModel note});
  Future<NoteModel> readNote({required String key});
  Future<bool> updateNote({required NoteModel note});
  Future<bool> deleteNote({required String key});
  Future<List<String>> keys({required UserModel user});
  void dispose();
}

class NoteRepository implements INoteRepository {
  Future<Database> database() => openDatabase(
        'igniteNotes.db',
        onCreate: (db, version) async {
          return await db.execute(
            'CREATE TABLE Notes ( '
            'id VARCHAR(255) NOT NULL PRIMARY KEY, '
            'idUser VARCHAR(255) NOT NULL, '
            'title VARCHAR(255) NOT NULL, '
            'text VARCHAR(255) NOT NULL, '
            'background BIGINT NOT NULL, '
            'data BIGINT NOT NULL, '
            'important VARCHAR(255) NOT NULL '
            ') ',
          );
        },
        // Set the version. This executes the onCreate function and provides a
        // path to perform database upgrades and downgrades.
        version: 1,
      );
  @override
  Future<bool> createNote({required NoteModel note}) async {
    try {
      Database db = await database();
      int response = await db.insert(
        "Notes",
        note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      db.close();
      return response >= 0;
      // final SharedPreferences instance = await SharedPreferences.getInstance();
      // return await instance.setString(note.id, note.toJson());
    } catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    }
  }

  @override
  Future<NoteModel> readNote({required String key}) async {
    try {
      Database db = await database();
      List<Map<String, Object?>> response =
          await db.query('Notes', where: 'id = ?', whereArgs: [key]);
      // final SharedPreferences instance = await SharedPreferences.getInstance();
      // String? response = instance.getString(key);

      db.close();
      return response.isEmpty
          ? throw I18nConst.notLocalizedNote
          : NoteModel.fromMap(response.first);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> updateNote({required NoteModel note}) async {
    try {
      Database db = await database();
      int response = await db
          .update('Notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
      // final SharedPreferences instance = await SharedPreferences.getInstance();
      // return await instance.setString(note.id, note.toJson());

      db.close();
      if (response >= 0) {
        return true;
      } else {
        throw I18nConst.editFailed;
      }
    } catch (e) {
      if (kDebugMode) print(e);
      throw I18nConst.editFailed;
    }
  }

  @override
  Future<bool> deleteNote({required String key}) async {
    try {
      Database db = await database();
      int response =
          await db.delete('Notes', where: 'id = ?', whereArgs: [key]);
      // final SharedPreferences instance = await SharedPreferences.getInstance();
      // return await instance.remove(key);

      db.close();
      return response >= 0;
    } catch (e) {
      if (kDebugMode) print(e);
      rethrow;
    }
  }

  @override
  Future<List<String>> keys({required UserModel user}) async {
    try {
      Database db = await database();
      List<Map<String, Object?>> response = await db.query('Notes',
          columns: ["id"], where: 'idUser = ?', whereArgs: [user.id]);
      // final SharedPreferences instance = await SharedPreferences.getInstance();
      // Set<String> keys = instance.getKeys();
      List<String> keysList = [];
      for (Map<String, Object?> key in response) {
        keysList.add(key["id"].toString());
      }
      db.close();
      return keysList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() async {}
}
