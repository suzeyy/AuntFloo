import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String? uId;
  String? fullName;
  String? emailAddress;

  UserModel({
    this.uId,
    this.fullName,
    this.emailAddress,
  });

  toJson() {
    return {
      'id': uId,
      'full_name': fullName,
      'email_address': emailAddress,
    };
  }

    factory UserModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>>documentSnapshot){
  final snapShot = documentSnapshot.data();
  return UserModel(
    uId: snapShot['id'],
    fullName: snapShot['full_name'],
    emailAddress: snapShot['email_address'],
  );
}
}