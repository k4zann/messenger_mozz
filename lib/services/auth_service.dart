import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> login(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }
}