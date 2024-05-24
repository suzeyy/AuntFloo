import 'package:aunt_flo/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:aunt_flo/profile.dart';
import 'package:get/get.dart';
import 'home.dart';
import 'insights.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Widget> screens = [Home(), Insights(), MyProfile()];

  int currentIndex = 0;
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Aunt Flo',
            style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
          ),
        ),
        backgroundColor: Colors.pinkAccent,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text('Help'),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text('About Us'),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: ListTile(
                    title: const Text('Toggle Dark Mode'),
                    trailing: Obx(() {
                      return Switch(
                        onChanged: (newValue) =>
                            themeController.isDarkMode.value = newValue,
                        value: themeController.isDarkMode.value,
                      );
                    }),
                  ),
                ),
              ];
            },
            offset: const Offset(10, 40),
          )
        ],
      ),
      body: screens.elementAt(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (selectedIndex) => setState(() => currentIndex = selectedIndex),
        selectedItemColor: Colors.pinkAccent.shade400,
        backgroundColor: Colors.pink.shade50,
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_month),
            label: 'Home',
            backgroundColor: Colors.pink.shade100,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.insights_outlined, color: Colors.black),
            label: 'Insights',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
