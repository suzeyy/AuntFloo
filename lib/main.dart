import 'package:aunt_flo/auntflo_main_app.dart';
import 'package:aunt_flo/controller/theme_controller.dart';
import 'package:aunt_flo/dashboard.dart';
import 'package:aunt_flo/edit_profile.dart';
import 'package:aunt_flo/firebase_options.dart';
import 'package:aunt_flo/insights.dart';
import 'package:aunt_flo/splash.dart';
import 'package:aunt_flo/utils/route_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aunt_flo/profile.dart';
import 'package:aunt_flo/home.dart';
import 'package:aunt_flo/login.dart';
import 'package:aunt_flo/create_account.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ///This function is to initialize Firebase in the project
  initializeFirebase();

  runApp(AuntfloMainApp());
}

void initializeFirebase() async {
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    if (kDebugMode) {
      print('Error establishing firebase connection $e');
    }
  }
}

// class MyApp extends StatefulWidget {
//   MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final List<Widget> screens = [Home(), Insights(), MyProfile()];
//
//   int currentIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     setState(() {
//
//     });
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Text(
//             'Aunt Flo',
//             style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
//           ),
//         ),
//         backgroundColor: Colors.pinkAccent,
//       ),
//       body: screens.elementAt(currentIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: currentIndex,
//         onTap: (selectedIndex) => {
//           setState(() {
//             currentIndex = selectedIndex;
//           })
//         },
//         selectedItemColor: Colors.pinkAccent.shade400,
//         backgroundColor: Colors.pink.shade50,
//         elevation: 0,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.calendar_month,
//                 // color: Colors.lightGreen,
//               ),
//               label: 'Home',
//               backgroundColor: Colors.pink.shade50),
//
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.insights,
//                 color: Colors.black,
//               ),
//               label: 'Insights'),
//           // BottomNavigationBarItem(
//           //     icon: Icon(
//           //       Icons.call,
//           //       // color: Colors.lightGreen,
//           //     ),
//           //     label: 'Contact'),
//           BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.person,
//                 // color: Colors.lightGreen,
//               ),
//               label: 'Profile'),
//
//         ],
//       ),
//     );
//   }
// }
