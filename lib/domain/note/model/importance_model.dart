import 'dart:convert';

import 'package:notes_ignite/i18n/i18n_const.dart';

class ImportanceModel {
  final String id;
  final String text;
  ImportanceModel({
    required this.id,
    required this.text,
  });

  static String initialIdImportance() => "2";

  static List<Map<String, dynamic>> _listMap() => [
        {"text": I18nConst.notImportance, "id": '0'},
        {"text": I18nConst.littleImportance, "id": '1'},
        {"text": I18nConst.mediumImportance, "id": '2'},
        {"text": I18nConst.highImportance, "id": '3'},
        {"text": I18nConst.veryImportant, "id": '4'}
      ];

  static List<ImportanceModel> listImportances() =>
      _listMap().map((e) => ImportanceModel.fromMap(e)).toList();

  static String textImportance(String id) =>
      listImportances().firstWhere((element) => element.id == id).text;

  ImportanceModel copyWith({
    String? id,
    String? text,
  }) {
    return ImportanceModel(
      id: id ?? this.id,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
    };
  }

  factory ImportanceModel.fromMap(Map<String, dynamic> map) {
    return ImportanceModel(
      id: map['id'] ?? '',
      text: map['text'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ImportanceModel.fromJson(String source) =>
      ImportanceModel.fromMap(json.decode(source));

  @override
  String toString() => 'ImportanceModel(id: $id, text: $text)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImportanceModel && other.id == id && other.text == text;
  }

  @override
  int get hashCode => id.hashCode ^ text.hashCode;
}
