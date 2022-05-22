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

}