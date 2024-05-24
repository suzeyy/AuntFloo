import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aunt_flo/model/user_model.dart';
import 'package:aunt_flo/service/firebase_database_service.dart';

class UserController extends GetxController {
  final usersList = <UserModel>[].obs;
  final firebaseDatabaseService = FirebaseDatabaseService();
  var userModel = UserModel().obs;
  var uId = "".obs;
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();
  final emailRegexPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  @override
  void onReady() {
    getUIDFromSharedPreferences();
    super.onReady();
  }

  ///Function to get user id in controller from SharedPreferences
  void getUIDFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? id = prefs.getString('id');
    if (id != null) {
      uId.value = id;
      print('UID Value ${uId.value}');
    }
    getUserDetailsUsingUidFromFirebase();
  }

  ///Get all users from firebase database
  void getAllUsersFromFirebase() async {
    usersList.value = await firebaseDatabaseService.getUsersFromDatabase();
  }

  ///Function to delete user from firebase using uid
  void deleteUserFromFirebaseUsingUID(
      {required String uId, required BuildContext dialogContext}) async {
    usersList.value =
        await firebaseDatabaseService.deleteUserUsingUID(uId: uId);
    Navigator.of(dialogContext).pop();
  }

  ///Get user details using Uid from Firebase
  getUserDetailsUsingUidFromFirebase() async {
    UserModel? userDetails;
    userDetails =
        await firebaseDatabaseService.getUserDetailsUsingUid(uId: uId.value);
    if (userDetails != null) {
      userModel.value = userDetails;
    }
  }

  ///Update user details using Uid in firebase
  updateUserDetailsUsingUidInFirebase({required BuildContext context}) async {
    final UserModel userModelRequest = UserModel(
      uId: uId.value,
      fullName: fullNameController.text,
      emailAddress: emailAddressController.text,
    );
    print('UserModel Request ${userModelRequest.toJson()}');
    if (uId.value.isNotEmpty) {
      await firebaseDatabaseService.updateUserUsingUID(
          uId: uId.value, userModel: userModelRequest);
    }

    ///Get back updated user details after an update is called
    getUserDetailsUsingUidFromFirebase();

    Navigator.of(context).pop();
  }
}
