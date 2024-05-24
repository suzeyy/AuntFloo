import 'package:aunt_flo/controller/user_controller.dart';
import 'package:aunt_flo/model/user_model.dart';
import 'package:aunt_flo/service/firebase_auth_service.dart';
import 'package:aunt_flo/service/firebase_database_service.dart';
import 'package:aunt_flo/utils/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          // Use the leading property to customize the back button
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navigate back to the previous page
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Obx(() {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: (userController.uId.value.isNotEmpty)
                ? FutureBuilder(
                    future: FirebaseDatabaseService()
                        .getUserDetailsUsingUid(uId: userController.uId.value),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        ///Connection to firebase has established, but has returned an error
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Error fetching data',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        ///Connection to firebase has established, and has returned a data
                        if (snapshot.hasData) {
                          // print('Name is ${userModel.fullName}');
                          final userModel = snapshot.data;
                          return ListView(children: [
                            ProfileImage(),
                            SizedBox(
                              height: 20,
                            ),
                            BasicDetails(userModel: userModel),
                            SizedBox(height: 20),
                            MenuWidgets(
                              title: 'Privacy Status',
                            ),
                            SizedBox(height: 5),
                            MenuWidgets(
                              title: 'Privacy Center',
                            ),
                            SizedBox(height: 5),
                            MenuWidgets(
                              title: 'Log Out',
                              onPressed: () async {
                                await showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return AlertDialog(
                                        title: Text('Signout User'),
                                        content: Text(
                                            'Are you sure want to Signout?'),
                                        actions: [
                                          InkWell(
                                            child: Text('Ok'),
                                            onTap: () {
                                              final firebaseAuthservice =
                                                  FirebaseAuthService();
                                              firebaseAuthservice.signout();
                                              Navigator.of(dialogContext).pop();
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      '/login');
                                            },
                                          ),
                                          InkWell(
                                            child: Text('Cancel'),
                                            onTap: () {
                                              Navigator.of(dialogContext).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                            )
                          ]);
                        }
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    })
                : CircularProgressIndicator(),
          );
        }));
  }
}

///This widget is used to display the circular profile images
class ProfileImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: CircleAvatar(
        radius: 18,
        child: ClipOval(
          child: Image.asset('assets/images/pig.png'),
        ),
      ),
    );
  }
}

///This is the widget for displaying the basic details of the user
class BasicDetails extends StatelessWidget {
  BasicDetails({required this.userModel});

  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.pinkAccent.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      width: MediaQuery.of(context).size.width - 40,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          userModel != null
              ? Text(
                  'Name: ${userModel!.fullName}',
                  style: TextStyle(fontSize: 20),
                )
              : Text('Name: -'),
          SizedBox(height: 10),
          userModel != null
              ? Text(
                  'Email: ${userModel!.emailAddress}',
                  style: TextStyle(fontSize: 20),
                )
              : Text('Email: -'),
          SizedBox(height: 25),
          ElevatedButton(
            onPressed: () => Navigator.of(context)
                .pushNamed(RouteConstants.editProfileRoute, arguments: userModel),
            child: Text('Edit Info'),
          ),
        ],
      ),
    );
  }
}

///This widget is common for creating menus
class MenuWidgets extends StatelessWidget {
  MenuWidgets({super.key, required this.title, this.onPressed});

  String title;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white60,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black12,
            width: 1.0,
          ),
        ),
        child: Center(child: Text(title)),
      ),
    );
  }
}
