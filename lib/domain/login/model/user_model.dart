import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';

class UserModel {
  final String name;
  final String email;
  final String id;
  final String photoUrl;
  UserModel({
    required this.name,
    required this.email,
    required this.id,
    required this.photoUrl,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? id,
    String? photoUrl,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'id': id,
      'photoUrl': photoUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      id: map['id'] ?? '',
      photoUrl: map['photoUrl'] ?? '',
    );
  }

  factory UserModel.fromGoogleSignIn(GoogleSignInAccount userGoogle) {
    return UserModel(
      name: userGoogle.displayName ?? '',
      email: userGoogle.email,
      id: userGoogle.id,
      photoUrl: userGoogle.photoUrl ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, id: $id, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.email == email &&
        other.id == id &&
        other.photoUrl == photoUrl;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ id.hashCode ^ photoUrl.hashCode;
  }
}
