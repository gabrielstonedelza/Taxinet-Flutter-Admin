import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taxinet_admin/splash.dart';
import "package:get/get.dart";

import 'controller/expensescontroller.dart';
import 'controller/extracontroller.dart';
import 'controller/inventoriescontroller.dart';
import 'controller/logincontroller.dart';
import 'controller/notificationcontroller.dart';
import 'controller/paymentcontroller.dart';
import 'controller/registrationcontroller.dart';
import 'controller/requestscontroller.dart';
import 'controller/usercontroller.dart';
import 'controller/userscontrollers.dart';
import 'controller/vehiclecontroller.dart';
import 'controller/walletcontroller.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await GetStorage.init();
  Get.put(MyLoginController());
  Get.put(InventoriesController());
  Get.put(NotificationController());
  Get.put(PaymentsController());
  Get.put(RequestController());
  Get.put(UserController());
  Get.put(UsersController());
  Get.put(VehiclesController());
  Get.put(WalletController());
  Get.put(ExpensesController());
  Get.put(MyRegistrationController());
  Get.put(ExtraController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRight,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

