import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';
import 'package:morphosis_demo/views/baseModule/baseController.dart';

class MainBottombar extends StatefulWidget {
  @override
  _MainBottombarState createState() => _MainBottombarState();
}

class _MainBottombarState extends State<MainBottombar> {
  final BaseController baseController = Get.put(BaseController());

  Future<bool> _willPop() async {
    return true;
  }

  final bottomNavBarList = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.list),
      label: 'All tasks',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.check),
      label: 'Completed Tasks',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => WillPopScope(
          onWillPop: _willPop,
          child: Scaffold(
            appBar: AppBar(
              title: Text("Morphosis Demo"),
            ),
            body: SafeArea(
                child: baseController.allTabs[baseController.currentIndex]),
            bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              // unselectedItemColor: ThemeConstants.primaryColor,
              // selectedItemColor: ThemeConstants.accentColor,
              currentIndex: baseController.currentIndex,
              onTap: (index) {
                baseController.currentIndex = index;
              },
              items: bottomNavBarList,
            ),
          ),
        ));
  }
}
