import 'package:flutter/material.dart';

class UserSesion {

  final String uid;
  final String name;
  final String email;
  final String photoURL;

  UserSesion({
    Key? key,
    required this.uid,
    required this.name,
    required this.email,
    required this.photoURL,
  });

  UserSesion.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        name = json['name'],
        email = json['email'],
        photoURL = json['photoURL'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
  };

}