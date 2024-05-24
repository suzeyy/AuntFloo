import 'package:aunt_flo/model/user_model.dart';
import 'package:aunt_flo/service/firebase_auth_service.dart';
import 'package:aunt_flo/service/firebase_database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  final emailRegexPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  var isChecked = false.obs;
  final firebaseAuth = FirebaseAuthService();
  final firebaseDatabaseService = FirebaseDatabaseService();

  ///This function is used to handle register user function
  handleRegisterUser({required BuildContext context}) async {
    if (formKey.currentState != null) {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        final email = emailAddressController.text;
        final password = passwordController.text;

        final user =
            await firebaseAuth.signUpUserWithEmailAndPassword(email, password);
        if (user != null) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('id', user.uid);
          final userModel = UserModel(
            uId: user.uid,
            fullName: fullNameController.text,
            emailAddress: emailAddressController.text,
          );

          firebaseDatabaseService.createUserInCloudFirebase(
              userModel: userModel);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Your account has been created successfully!!'),
            duration: Duration(milliseconds: 1000),
            // Navigator.of(context).pushReplacementNamed('/dashboard');
          ));
          await Future.delayed(const Duration(milliseconds: 1000));
          Navigator.of(context).pushReplacementNamed('/dashboard');
        } else {
          print('Register Error');
        }
      }
    }
  }
}
