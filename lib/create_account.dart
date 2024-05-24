import 'package:aunt_flo/controller/register_controller.dart';
import 'package:aunt_flo/service/firebase_auth_service.dart';
import 'package:aunt_flo/service/firebase_database_service.dart';
import 'package:aunt_flo/utils/route_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'model/user_model.dart';

class CreateAccount extends StatefulWidget {
  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
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
                  kIsWeb
                      ? FractionallySizedBox(
                          widthFactor: 0.5,
                          child: Container(
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                              decoration: BoxDecoration(
                                color: Colors.pinkAccent.withOpacity(0.3),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                              // child: SvgPicture.network('https://svgur.com/i/yCT.svg'),
                              child: Center(
                                child: Image.asset(
                                  'assets/images/pre.png',
                                ),
                              )),
                        )
                      : SizedBox.shrink(),
                  FractionallySizedBox(
                      widthFactor: kIsWeb ? 0.5 : 1,
                      child: Container(
                          height: constraints.maxHeight,
                          width: constraints.maxWidth,
                          decoration: BoxDecoration(
                              color: Colors.pinkAccent.withOpacity(0.2),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 20),
                            child: SingleChildScrollView(
                              child: Form(
                                  key: registerController.formKey,
                                  child: Container(
                                      padding: kIsWeb
                                          ? EdgeInsets.zero
                                          : EdgeInsets.only(left: 10),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                      'assets/images/pre.png',
                                                      height: 300,
                                                    ),
                                                  ),
                                            Text(
                                              'Create your account',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 23,
                                                  color: Colors.pink.shade300),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Full Name',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: Colors.black
                                                      .withOpacity(0.7)),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20, left: 0, top: 5),
                                                child: SizedBox(
                                                  height: 35,
                                                  child: TextFormField(
                                                    controller:
                                                        registerController
                                                            .fullNameController,
                                                    keyboardType:
                                                        TextInputType.name,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText:
                                                          'Enter your Name',
                                                      hintStyle: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    validator: (fullNameValue) {
                                                      if (fullNameValue ==
                                                              null ||
                                                          fullNameValue
                                                              .trim()
                                                              .isEmpty) {
                                                        return 'Please Enter  Full Name';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                )),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text('Email Address',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black
                                                        .withOpacity(0.7))),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20, left: 0),
                                              child: SizedBox(
                                                height: 35,
                                                child: TextFormField(
                                                  controller: registerController
                                                      .emailAddressController,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: 'you@example.com',
                                                    hintStyle:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  validator: (emailValue) {
                                                    if (emailValue == null ||
                                                        emailValue
                                                            .trim()
                                                            .isEmpty) {
                                                      return 'Please enter your email address';
                                                    }
                                                    final regex = RegExp(
                                                        registerController
                                                            .emailRegexPattern);
                                                    if (!regex
                                                        .hasMatch(emailValue)) {
                                                      return 'Please enter a valid email';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              'Password',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black
                                                      .withOpacity(0.7)),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 20),
                                                child: SizedBox(
                                                  height: 35,
                                                  child: TextFormField(
                                                    controller:
                                                        registerController
                                                            .passwordController,
                                                    keyboardType: TextInputType
                                                        .visiblePassword,
                                                    obscureText: true,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText:
                                                          'Enter a password',
                                                      hintStyle: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    validator: (passwordValue) {
                                                      if (passwordValue ==
                                                              null ||
                                                          passwordValue
                                                              .trim()
                                                              .isEmpty) {
                                                        return 'Please enter password';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                )),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              'Confirm Password',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black
                                                      .withOpacity(0.7)),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0, right: 20),
                                                child: SizedBox(
                                                  height: 35,
                                                  child: TextFormField(
                                                    controller: registerController
                                                        .confirmPassController,
                                                    keyboardType: TextInputType
                                                        .visiblePassword,
                                                    obscureText: true,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText:
                                                          'Re-enter your password',
                                                      hintStyle: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                    validator: (confirmValue) {
                                                      if (confirmValue ==
                                                              null ||
                                                          confirmValue
                                                              .trim()
                                                              .isEmpty) {
                                                        return 'Please enter password';
                                                      }
                                                      if (confirmValue !=
                                                          registerController
                                                              .passwordController
                                                              .text) {
                                                        return 'Password doesn\'t match';
                                                      }
                                                      ;
                                                      return null;
                                                    },
                                                  ),
                                                )),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 0,
                                                ),
                                                Obx(() {
                                                  return Checkbox(
                                                    checkColor: Colors.white,
                                                    activeColor:
                                                        Colors.pink.shade300,
                                                    value: registerController
                                                        .isChecked.value,
                                                    onChanged: (newValue) {
                                                      if (newValue != null) {
                                                        registerController
                                                            .isChecked
                                                            .value = newValue;
                                                      }
                                                    },
                                                  );
                                                }),
                                                Flexible(
                                                  child: Text(
                                                    'By signing up you agree to our terms, conditions and privacy policy.',
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black
                                                          .withOpacity(0.7),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              height: 40,
                                              width: constraints.maxWidth,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20, left: 0),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 3,
                                                    backgroundColor:
                                                        Colors.pink.shade300,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  onPressed: () =>
                                                      registerController
                                                          .handleRegisterUser(
                                                              context: context),
                                                  child: const Text(
                                                    'Create new',
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                  text:
                                                      "Already have an account ? ",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.blueGrey
                                                          .withOpacity(0.8)),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: "Sign In",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors
                                                              .pink.shade400,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline),
                                                      recognizer: TapGestureRecognizer()
                                                        ..onTap = () =>
                                                            Navigator.pushNamed(
                                                                context,
                                                                RouteConstants
                                                                    .loginRoute),
                                                    ),
                                                  ]),
                                            ),
                                          ]))),
                            ),
                          )))
                ]);
              }),
            ),
          ),
        ));
  }
}
