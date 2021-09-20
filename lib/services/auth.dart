import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymandfood/model/user.dart';
import 'package:gymandfood/widgets/widgets.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(userId: user.uid) : null;
  }

  Future updateUserPassword(
      BuildContext context, String currentPassword, String newPassword) async {
    try {
      final user = await FirebaseAuth.instance.currentUser;
      final cred = EmailAuthProvider.credential(
          email: user.email, password: currentPassword);
      user.reauthenticateWithCredential(cred).then((value) {
        user.updatePassword(newPassword).then((valuee) {
          showAlertDialog(context, "Changed", "Password Changed");
          print("Password Changed");
        }).catchError((error) {
          print("Errorr");
        });
      }).catchError((err) {
        showAlertDialog(context, "Error", "Check Passwords");
        print("Errorreee");
      });
    } catch (e) {
      showAlertDialog(context, "Error", "Check Passwords");
      print("Errorreeerrrr");
    }
  }

  Future createUser(
      String userId, String name, String email, String password) async {
    Map<String, String> userData = {
      "userId": userId,
      "userName": name,
      "userEmail": email,
      "userPassword": password
    };

    return await FirebaseFirestore.instance
        .collection("user")
        //.doc('user_info')
        //.collection('user_info')
        .doc(userId)
        .set(userData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future singInEmailAndPass(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user.uid;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          return "Error: User Not Found";
        case "wrong-password":
          return "Error: Wrong password";
      }
      return "Error: " + e.code;
    }
  }

  Future signUpWithEmailAndPass(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      //print("UserID: ${userCredential.user.uid}");
      return userCredential.user.uid;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "account-exists-with-different-credential":
          return "Error: Account exists with different credential";
        case "email-already-in-use":
          return "Error: Email already in use";
        case "weak-password":
          return "Error: Weak password";
        case "invalid-email":
          return "Error: Not a valid email";
      }
      return "Error: " + e.code;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
