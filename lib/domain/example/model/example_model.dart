import 'dart:convert';

class ExampleModel {
  final String example;
  ExampleModel({
    required this.example,
  });

  ExampleModel copyWith({
    String? example,
  }) {
    return ExampleModel(
      example: example ?? this.example,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'example': example,
    };
  }

  factory ExampleModel.fromMap(Map<String, dynamic> map) {
    return ExampleModel(
      example: map['example'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ExampleModel.fromJson(String source) =>
      ExampleModel.fromMap(json.decode(source));

  @override
  String toString() => 'ExampleModel(example: $example)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExampleModel && other.example == example;
  }

  @override
  int get hashCode => example.hashCode;
}
