import 'dart:async';
import 'dart:convert';

import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:get_storage/get_storage.dart';
import 'package:taxinet_admin/admin/passengers.dart';
import 'package:taxinet_admin/admin/payments.dart';
import 'package:taxinet_admin/admin/unreadschedules.dart';
import 'package:taxinet_admin/controller/paymentcontroller.dart';
import 'package:http/http.dart' as http;
import '../constants/app_colors.dart';
import '../controller/inventoriescontroller.dart';
import '../controller/notificationcontroller.dart';
import '../controller/requestscontroller.dart';
import '../controller/usercontroller.dart';
import '../controller/userscontrollers.dart';
import '../controller/vehiclecontroller.dart';
import '../controller/walletcontroller.dart';
import 'allrequests.dart';
import 'drivers.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final UserController userController = Get.find();
  final PaymentsController paymentController = Get.find();
  final InventoriesController inventoriesController = Get.find();
  final NotificationController notificationController = Get.find();
  final RequestController requestController = Get.find();
  final UsersController usersController = Get.find();
  final VehiclesController vehicleController = Get.find();
  final WalletController walletController = Get.find();

  final storage = GetStorage();

  late String username = "";

  late String uToken = "";

  late String userid = "";

  var items;

  bool isFetching = true;

  bool isLoading = true;

  late List allNotifications = [];

  late List yourNotifications = [];

  late List notRead = [];

  late List triggered = [];

  late List unreadNotifications = [];

  late List triggeredNotifications = [];

  late List notifications = [];

  late List allNots = [];

  late Timer _timer;

  Future<void> getAllTriggeredNotifications() async {
    const url = "https://taxinetghana.xyz/user_triggerd_notifications/";
    var myLink = Uri.parse(url);
    final response =
    await http.get(myLink, headers: {"Authorization": "Token $uToken"});
    if (response.statusCode == 200) {
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      triggeredNotifications = json.decode(jsonData);
      triggered.assignAll(triggeredNotifications);
    }
  }

  Future<void> getAllUnReadNotifications() async {
    const url = "https://taxinetghana.xyz/user_notifications/";
    var myLink = Uri.parse(url);
    final response =
    await http.get(myLink, headers: {"Authorization": "Token $uToken"});
    if (response.statusCode == 200) {
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      yourNotifications = json.decode(jsonData);
      notRead.assignAll(yourNotifications);
    }
  }

  Future<void> getAllNotifications() async {
    const url = "https://taxinetghana.xyz/get_all_driver_notifications/";
    var myLink = Uri.parse(url);
    final response =
    await http.get(myLink, headers: {"Authorization": "Token $uToken"});
    if (response.statusCode == 200) {
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      allNotifications = json.decode(jsonData);
      allNots.assignAll(allNotifications);
    }
  }

  unTriggerNotifications(int id) async {
    final requestUrl = "https://taxinetghana.xyz/user_read_notifications/$id/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.put(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      "Authorization": "Token $uToken"
    }, body: {
      "notification_trigger": "Not Triggered",
    });
    if (response.statusCode == 200) {}
  }

  updateReadNotification(int id) async {
    final requestUrl = "https://taxinetghana.xyz/user_read_notifications/$id/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.put(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      "Authorization": "Token $uToken"
    }, body: {
      "read": "Read",
    });
    if (response.statusCode == 200) {}
  }

  @override
  void initState() {
    super.initState();
    if (storage.read("userToken") != null) {
      uToken = storage.read("userToken");
    }
    if (storage.read("username") != null) {
      username = storage.read("username");
    }
    if (storage.read("userid") != null) {
      userid = storage.read("userid");
    }

    inventoriesController.getAllInventories();
    inventoriesController.getAllInventoriesToday();
    paymentController.getAllPayments();
    paymentController.getAllPaymentsToday();
    notificationController.getAllNotifications(uToken);
    notificationController.getAllUnReadNotifications(uToken);
    requestController.getActiveSchedules();
    requestController.getAllSchedules();
    requestController.getOneTimeSchedules();
    requestController.getDailySchedules();
    requestController.getDaysSchedules();
    requestController.getWeeklySchedules();
    requestController.getAllDrivers();
    requestController.getAllPassengers();
    requestController.getAllInvestors();
    requestController.getAllAssignedDrivers();
    userController.getUserProfile(uToken);
    userController.getAllUsers(uToken);
    userController.getAllDrivers();
    userController.getAllPassengers();
    walletController.getAllWallet();

    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      inventoriesController.getAllInventories();
      inventoriesController.getAllInventoriesToday();
      paymentController.getAllPayments();
      paymentController.getAllPaymentsToday();
      notificationController.getAllNotifications(uToken);
      notificationController.getAllUnReadNotifications(uToken);
      requestController.getActiveSchedules();
      requestController.getAllSchedules();
      requestController.getOneTimeSchedules();
      requestController.getDailySchedules();
      requestController.getDaysSchedules();
      requestController.getWeeklySchedules();
      requestController.getAllDrivers();
      requestController.getAllPassengers();
      requestController.getAllInvestors();
      requestController.getAllAssignedDrivers();
      userController.getUserProfile(uToken);
      userController.getAllUsers(uToken);
      userController.getAllDrivers();
      userController.getAllPassengers();
      walletController.getAllWallet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: ListView(
          children: [
            const SizedBox(height:10),
            Padding(
                padding: const EdgeInsets.only(left:16, right:16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GetBuilder<UserController>(builder:(controller){
                          return Text(controller.username,style:const TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 20),);
                        })
                        ,
                        const SizedBox(height:20),
                        const Text("DashBoard",style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold,),),
                      ],
                    )
                  ],
                )
            ),
            const SizedBox(height:20),
            Padding(
              padding: const EdgeInsets.only(left:18.0,right:18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Get.to(() => const AllUnReadSchedules());
                      },
                      child: Card(
                        elevation: 12,
                        child: Container(
                          height:150,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/sedan.png",width:42),
                                const SizedBox(height:20),
                                const Text("Requests",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),)
                              ]
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width:20),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context){
                        //   return const CustomerSummary();
                        // }));
                      },
                      child: Card(
                        elevation: 12,
                        child: Container(
                          height:150,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/investor.png",width:42,height: 42,),
                                const SizedBox(height:20),
                                const Text("Investors",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),)
                              ]
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left:18.0,right:18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Get.to(() => const AllDrivers());
                      },
                      child: Card(
                        elevation: 12,
                        child: Container(
                          height:150,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/taxi-driver.png",width:42),
                                const SizedBox(height:20),
                                const Text("Drivers",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),)
                              ]
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width:20),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Get.to(() => const Passengers());
                      },
                      child: Card(
                        elevation: 12,
                        child: Container(
                          height:150,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/passenger.png",width:42),
                                const SizedBox(height:20),
                                const Text("Passengers",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),)
                              ]
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left:18.0,right:18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Get.to(() => const Payments());
                      },
                      child: Card(
                        elevation: 12,
                        child: Container(
                          height:150,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/money.png",width:42),
                                const SizedBox(height:20),
                                const Text("Payments",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),)
                              ]
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width:20),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context){
                        //   return const CustomerSummary();
                        // }));
                      },
                      child: Card(
                        elevation: 12,
                        child: Container(
                          height:150,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/budget.png",width:42),
                                const SizedBox(height:20),
                                const Text("Expenses",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),)
                              ]
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}