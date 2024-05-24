import 'package:aunt_flo/controller/login_controller.dart';
import 'package:aunt_flo/utils/route_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:aunt_flo/service/firebase_auth_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.1),
      body: SafeArea(
        child: Center(
          child: Container(
            width: kIsWeb
                ? MediaQuery.of(context).size.width / 1.5
                : MediaQuery.of(context).size.width,
            height: kIsWeb
                ? MediaQuery.of(context).size.height / 1.5
                : MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Wrap(children: [
                FractionallySizedBox(
                  widthFactor: kIsWeb ? 0.5 : 1,
                  child: Container(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                        color: Colors.pinkAccent.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        )),
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: SingleChildScrollView(
                        child: Form(
                          key: loginController.formKey,
                          child: Container(
                            padding: kIsWeb
                                ? EdgeInsets.zero
                                : EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                kIsWeb
                                    ? SizedBox(height: 10)
                                    : SizedBox(
                                        height: 10,
                                      ),
                                kIsWeb
                                    ? SizedBox.shrink()
                                    : Center(
                                        child: Image.asset(
                                          'assets/images/img.png',
                                          height: 300,
                                        ),
                                      ),
                                Text("Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 25,
                                        color: Colors.pink.shade300)),
                                SizedBox(
                                  height: 5,
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "Don't have an account yet? ",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.blueGrey.withOpacity(0.8),
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "Sign Up",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.pink.shade400,
                                              decoration:
                                                  TextDecoration.underline),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => Navigator.pushNamed(
                                                context,
                                                RouteConstants
                                                    .registerRoute),
                                        ),
                                      ]),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text('Email Address',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black.withOpacity(0.7))),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 20, left: 0),
                                  child: SizedBox(
                                    height: 50,
                                    child: TextFormField(
                                      controller: loginController.emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'you@example.com',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.spaceBetween,
                                  children: <Widget>[
                                    FractionallySizedBox(
                                      widthFactor: 0.7,
                                      child: Text('Password',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Colors.black.withOpacity(0.7))),
                                    ),
                                    FractionallySizedBox(
                                      widthFactor: 0.3,
                                      child: Text('Forgot your password?',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.pink.shade500,
                                            decoration: TextDecoration.underline,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20, left: 0),
                                  child: TextFormField(
                                    controller:
                                        loginController.passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter a password',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 0,
                                    ),
                                    Obx(() {
                                      return Checkbox(
                                        checkColor: Colors.white,
                                        activeColor: Colors.pink.shade300,
                                        value: loginController.isChecked.value,
                                        onChanged: (bool? value) {
                                          if (value != null) {
                                            loginController.toggleCheckbox(value);
                                          }
                                        },
                                      );
                                    }),
                                    Text(
                                      'Remember me',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.7)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 45,
                                  width: constraints.maxWidth,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(right: 20, left: 0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 3,
                                        backgroundColor: Colors.pink.shade300,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      onPressed: () async {
                                        final email =
                                            loginController.emailController.text;
                                        final password = loginController
                                            .passwordController.text;
                                        final firebaseAuthService =
                                            FirebaseAuthService();
                                        User? user = await firebaseAuthService
                                            .loginInWithEmailAndPassword(
                                                email, password);
                                        if (user != null) {
                                          final SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          prefs.setString('id', user.uid);
                                          Navigator.of(context)
                                              .pushReplacementNamed(RouteConstants.dashboardRoute);
                                        } else {
                                          if (context.mounted) {
                                            await showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext dialogContext) {
                                                  return AlertDialog(
                                                    icon: Icon(Icons.warning),
                                                    title: Text('Login Error'),
                                                    content: Text(
                                                        'Couldn\'t login. Please verify your email or password!'),
                                                    actions: [
                                                      InkWell(
                                                        child: Text('OK'),
                                                        onTap: () {
                                                          Navigator.of(
                                                                  dialogContext)
                                                              .pop();
                                                        },
                                                      )
                                                    ],
                                                  );
                                                });
                                          }
                        
                                          print('Login failed');
                                        }
                                      },
                                      child: Text(
                                        'LOGIN',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                kIsWeb
                    ? FractionallySizedBox(
                        widthFactor: 0.5,
                        child: Container(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth,
                            decoration: BoxDecoration(
                              color: Colors.pinkAccent.withOpacity(0.3),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            // child: SvgPicture.network('https://svgur.com/i/yCT.svg'),
                            child: Center(
                              child: Image.asset(
                                'assets/images/img.png',
                              ),
                            )),
                      )
                    : SizedBox.shrink(),
              ]);
            }),
          ),
        ),
      ),
    );
  }
}
