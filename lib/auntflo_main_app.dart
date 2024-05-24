import 'package:aunt_flo/controller/theme_controller.dart';
import 'package:aunt_flo/create_account.dart';
import 'package:aunt_flo/dashboard.dart';
import 'package:aunt_flo/edit_profile.dart';
import 'package:aunt_flo/home.dart';
import 'package:aunt_flo/insights.dart';
import 'package:aunt_flo/login.dart';
import 'package:aunt_flo/profile.dart';
import 'package:aunt_flo/splash.dart';
import 'package:aunt_flo/utils/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuntfloMainApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  AuntfloMainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
       () {
        return GetMaterialApp(
          title: 'Aunt Flo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode:
              themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
          initialRoute: RouteConstants.rootRoute,
          routes: {
            RouteConstants.rootRoute: (BuildContext context) => Splash(),
            RouteConstants.homeRoute: (context) => Home(),
            RouteConstants.loginRoute: (context) => Login(),
            RouteConstants.registerRoute: (context) => CreateAccount(),
            RouteConstants.insightsRoute: (context) => Insights(),
            RouteConstants.viewProfileRoute: (context) => MyProfile(),
            RouteConstants.dashboardRoute: (context) => Dashboard(),
            RouteConstants.editProfileRoute: (context) => EditProfile(),
          },
        );
      }
    );
  }
}
