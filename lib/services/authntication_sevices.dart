import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial_app/models/user_model.dart';
import 'package:firebase_tutorial_app/services/storage_service.dart';
import 'package:uuid/uuid.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<String> signUp(
      {required String email,
      required String password,
      required String username,
      required String gender,
      required int age,
      required Uint8List image}) async {
    String result = "";

    try {
      var userCredentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      var user = userCredentials.user;
      var uid = user!.uid;

      var fileName = email + const Uuid().v4();
      var profilePicUrl = await StorageService().uploadImage(
          file: image,
          firstSub: "ProfilePictures",
          secondSub: email,
          fileName: fileName);

      UserModel userModel = UserModel(
          userName: username,
          age: age,
          email: email,
          gender: gender,
          profilePicUrl: profilePicUrl);

      _firestore.collection("UserInformation").doc(email).set(userModel.toDB());

      result = "Success";
    } catch (error) {
      result = error.toString();
    }

    return result;
  }

  Future<String> login(
      {required String email, required String password}) async {
    String result = "";
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      result = 'Success';
    } catch (error) {
      result = error.toString();
    }
    return result;
  }

  logout() async {
    await _auth.signOut();
  }
}
