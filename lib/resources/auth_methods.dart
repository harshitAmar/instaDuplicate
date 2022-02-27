import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta/models/user_model.dart' as model;

import 'package:insta/resources/storage_methods.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap =
        await _firestore.collection("users").doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String userName,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          userName.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String photoUrl = await StorageMethods()
            .uploadImageToFireBaseStorage('profilePics', file, false);
        model.User user = model.User(
          bio: bio,
          username: userName,
          uid: cred.user!.uid,
          email: email,
          photoUrl: photoUrl,
          followers: [],
          following: [],
        );
        await _firestore.collection("users").doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = "success";
      }
    }
    // on FirebaseAuthException catch (err) {
    //   if (err.code == 'invalid-email') {
    //     res = 'the email is badly formatted';
    //   } else if (err.code == 'weak-password') {
    //     res = 'your password should be at least 6 characters';
    //   }
    // }
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some Error Occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all fields";
      }
      // }on FirebaseAuthException catch(e){
      //   if(e.code =="user-not-found"){

      //   }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
