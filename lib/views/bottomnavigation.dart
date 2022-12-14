import 'dart:async';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:get/get.dart';

import '../admin/dashboard.dart';
import '../admin/inventories.dart';
import '../admin/notifications.dart';
import '../admin/payments.dart';
import '../admin/vehicles.dart';
import '../controller/notificationcontroller.dart';


class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  final storage = GetStorage();
  late String username = "";
  late String uToken = "";
  int selectedIndex = 0;
  late PageController pageController;
  bool hasInternet = false;
  late StreamSubscription internetSubscription;
  NotificationController notificationController = Get.find();
  late Timer _timer;
  final screens = [
    const Dashboard(),
    const Inventories(),
    const Notifications(),
    const Vehicles(),
  ];

  void onSelectedIndex(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    internetSubscription = InternetConnectionChecker().onStatusChange.listen((status){
      final hasInternet = status == InternetConnectionStatus.connected;
      setState(()=> this.hasInternet = hasInternet);
    });
    if (storage.read("userToken") != null) {
      uToken = storage.read("userToken");
    }
    if (storage.read("username") != null) {
      username = storage.read("username");
    }
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  void dispose(){
    internetSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return SafeArea(
        child:Scaffold(
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
                indicatorColor: Colors.blue.shade100,
                labelTextStyle:  MaterialStateProperty.all(
                    const TextStyle(fontSize:14, fontWeight: FontWeight.bold)
                )
            ),
            child: NavigationBar(
              animationDuration: const Duration(seconds: 3),
              selectedIndex: selectedIndex,
              onDestinationSelected: (int index) => setState((){
                selectedIndex = index;
              }),
              height: 60,
              backgroundColor: Colors.white,
              destinations: [
                const NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: "Home",
                ),
                const NavigationDestination(
                  icon: Icon(Icons.checklist_rtl_outlined),
                  selectedIcon: Icon(Icons.checklist_rtl),
                  label: "Inventories",
                ),
                GetBuilder<NotificationController>(builder: (controller){
                  return NavigationDestination(
                    icon: Badge(
                        animationDuration: const Duration(seconds: 3),
                        // padding: const EdgeInsets.all(2),
                        // position: BadgePosition.bottomStart(),
                        toAnimate: true,
                        shape: BadgeShape.circle,
                        badgeColor: Colors.red,
                        // borderRadius: BorderRadius.circular(8),
                        badgeContent: Text("${notificationController.notRead.length}",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize:15)),
                        child: const Icon(Icons.notifications_outlined)),
                    selectedIcon: const Icon(Icons.notifications),
                    label: "Notifications",
                  );
                }),
                const NavigationDestination(
                  icon: Icon(Icons.car_rental_outlined),
                  selectedIcon: Icon(Icons.car_rental),
                  label: "Vehicles",
                ),
              ],
            ),
          ),
          body: screens[selectedIndex],
        )
    );
  }
}
