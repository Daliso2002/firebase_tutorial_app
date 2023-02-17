import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String userName;
  String email;
  int age;
  String gender;
  String profilePicUrl;

  UserModel(
      {required this.userName,
      required this.age,
      required this.email,
      required this.gender,
      required this.profilePicUrl});

  factory UserModel.fromDB(DocumentSnapshot snapshot) {
    var map = snapshot as Map<String, dynamic>;
    return UserModel(
        userName: map['username'],
        age: map['age'],
        email: map['email'],
        gender: map['gender'],
        profilePicUrl: map['profilePicUrl']);
  }

  Map<String, dynamic> toDB() {
    return {
      'username': userName,
      'age': age,
      'gender': gender,
      'profilePicUrl': profilePicUrl,
      'email': email,
    };
  }
}
