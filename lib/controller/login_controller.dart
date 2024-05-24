import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aunt_flo/service/firebase_auth_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isChecked = false.obs;

  @override
  void onReady() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString('email');
    final String? password = prefs.getString('password');

    ///Set default username and password to controllers
    if (email != null) {
      if (email.isNotEmpty) {
        emailController.text = email;
      }
    }
    if (password != null) {
      if (password.isNotEmpty) {
        passwordController.text = password;
      }
    }

    super.onReady();
  }

  ///This function is used to togggle the checkbox of login
  toggleCheckbox(bool newValue) {
    isChecked.value = newValue;
  }

  ///This function is to save/remove user credentials from session
  saveRemoveUserCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    print(prefs);
    if (isChecked.value == true) {
      await prefs.setString('email', emailController.text);
      await prefs.setString('password', passwordController.text);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
    }
  }

  ///This function is called when login is onPressed
  handleLogin(BuildContext context) async {
    if (isChecked.value) {
      final email = emailController.text;
      final password = passwordController.text;
      final firebaseAuthService = FirebaseAuthService();
      User? user = await firebaseAuthService.loginInWithEmailAndPassword(
          email, password);
      if (user != null) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('id', user.uid);
        saveRemoveUserCredentials();
        Navigator.of(context).pushReplacementNamed('/dashboard');
      } else {
        print('Login Failed');
      }
    } else {
      print('Please check the terms');
    }
  }
}
