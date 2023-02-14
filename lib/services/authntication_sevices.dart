import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;

  Future<String> signUp(
      {required String email,
      required String password,
      required String username,
      required String gender,
      required int age}) async {
    String result = "";

    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
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
