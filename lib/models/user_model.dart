import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String name;
  final String email;
  final String uid;
  const UserModel({
    required this.name,
    required this.email,
    required this.uid,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? uid,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      uid: map['\$id'] as String,
    );
  }

}
