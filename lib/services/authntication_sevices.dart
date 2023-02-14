import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<String> signUp(
      {required String email,
      required String password,
      required String username,
      required String gender,
      required int age}) async {
    String result = "";

    try {
      var userCredentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      var user = userCredentials.user;
      var uid = user!.uid;

      _firestore.collection("UserInformation").doc(email).set({
        "uid": uid,
        "email": email,
        "username": username,
        "gender": gender,
        "age": age,
      });

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
