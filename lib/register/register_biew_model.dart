import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:p4_chat/firebase_errors.dart';
import 'package:p4_chat/register/register_navigator.dart';

class RegisterViewModel extends ChangeNotifier {
  late RegisterNavigator navigator;

void registerFirebaseAuth(String Email , String Password) async{
  try {
    navigator.showLoading();
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: Email,
      password: Password,
    );
    print('firebase auth id : ${credential.user?.uid}');
    navigator.hideLoading();
    navigator.showMessage('Register successfully');
  } on FirebaseAuthException catch (e) {
    if (e.code == FirebaseErrors.weakPassword) {
      navigator.hideLoading();
      navigator.showMessage("The password provided is too weak.");
      print('The password provided is too weak.');
    } else if (e.code == FirebaseErrors.emailAlreadyInUse) {
      print('The account already exists for that email.');
      navigator.hideLoading();
      navigator.showMessage("The account already exists for that email.");
    }
  } catch (e) {
    print(e);
    navigator.hideLoading();
    navigator.showMessage('Something went wrong');
  }
}
}
