import 'dart:async';
import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:get_storage/get_storage.dart';
import 'package:taxinet_admin/admin/passengers.dart';
import 'package:taxinet_admin/admin/payments.dart';
import 'package:taxinet_admin/admin/searchpage.dart';
import 'package:taxinet_admin/admin/sendsms.dart';
import 'package:taxinet_admin/admin/unreadschedules.dart';
import 'package:taxinet_admin/admin/userregistration.dart';
import 'package:taxinet_admin/admin/wallets.dart';
import 'package:taxinet_admin/controller/paymentcontroller.dart';
import 'package:http/http.dart' as http;
import '../constants/app_colors.dart';
import '../controller/expensescontroller.dart';
import '../controller/extracontroller.dart';
import '../controller/inventoriescontroller.dart';
import '../controller/notificationcontroller.dart';
import '../controller/requestscontroller.dart';
import '../controller/usercontroller.dart';
import '../controller/userscontrollers.dart';
import '../controller/vehiclecontroller.dart';
import '../controller/walletcontroller.dart';
import 'allusers.dart';
import 'drivers.dart';
import 'driversforinspection.dart';
import 'expensestoday.dart';
import 'extras.dart';
import 'investors.dart';

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
  final ExpensesController expensesController = Get.find();
  final ExtraController extraController = Get.find();

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

  bool hasAlertLocked = false;
  int alertLockCount = 0;
  int alertUnLockCount = 0;
  int alertLock = 0;
  final SendSmsController sendSms = SendSmsController();

  List driversNumbers = ["+233547236997", "+233245086675", "+233509556768", "+233246873879", "+233244858459", "+233551300168", "+233243143292",
  "+233244710522", "+233596842925","+233552870497"];
  List driversTrackingNumbers = ["+233594095982", "+233594097253", "+233594163113", "+233594143106", "+233594140062", "+233594162360",
  "+233594173115", "+233594140058", "+233594072852","+233552870497"];


  void checkTheTime(){
    var hour = DateTime.now().hour;

    switch (hour) {
    case 23:
      if (alertLockCount == 0){
        for(var i in driversNumbers){
          sendSms.sendMySms(i, "Taxinet",
              "Attention!,please be advised, your car will be locked in one hour time,thank you.");
        }
      }
      setState(() {
        alertLockCount = 1;
      });
      break;
    case 00:
      print(hour);
      if (alertLock == 0){
        sendSms.sendMySms("+233593380008", "Taxinet",
            "All cars are locked successfully.");
        for(var i in driversTrackingNumbers){
          sendSms.sendMySms(i, "0244529353", "relay,1\%23#");
        }
        for(var i in driversNumbers){
          sendSms.sendMySms(i, "Taxinet", "Attention!,your car is locked.");
        }
      }
      setState(() {
        alertLock = 1;
      });
      break;
    }
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
    checkTheTime();

    inventoriesController.getAllInventories();
    inventoriesController.getAllInventoriesToday();
    paymentController.getAllPayments();
    paymentController.getAllPaymentsToday();
    notificationController.getAllNotifications(uToken);
    notificationController.getAllUnReadNotifications(uToken);
    requestController.getActiveSchedules();
    requestController.getAllSchedules();
    requestController.getShortTripSchedules();
    requestController.getDailySchedules();
    requestController.getDaysSchedules();
    requestController.getWeeklySchedules();
    requestController.getAllDrivers();
    requestController.getAllPassengers();
    requestController.fetchUsers();
    requestController.fetchBlockedUsers();
    requestController.getAllInvestors();
    requestController.getAllAssignedDrivers();
    userController.getUserProfile(uToken);
    userController.getAllUsers();
    userController.getAllDrivers();
    userController.getAllPassengers();
    walletController.getAllWallet();
    vehicleController.getAllVehicles();
    expensesController.getAllExpenses();
    expensesController.getAllExpensesToday();
    extraController.getAllDriversExtras();

    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      inventoriesController.getAllInventories();
      inventoriesController.getAllInventoriesToday();
      paymentController.getAllPayments();
      paymentController.getAllPaymentsToday();
      notificationController.getAllNotifications(uToken);
      notificationController.getAllUnReadNotifications(uToken);
      requestController.getActiveSchedules();
      requestController.getAllSchedules();
      requestController.getShortTripSchedules();
      requestController.getDailySchedules();
      requestController.getDaysSchedules();
      requestController.getWeeklySchedules();
      requestController.getAllDrivers();
      requestController.getAllPassengers();
      requestController.getAllInvestors();
      requestController.getAllAssignedDrivers();
      requestController.fetchUsers();
      requestController.fetchBlockedUsers();
      userController.getUserProfile(uToken);
      userController.getAllUsers();
      userController.getAllDrivers();
      userController.getAllPassengers();
      walletController.getAllWallet();
      vehicleController.getAllVehicles();
      expensesController.getAllExpenses();
      expensesController.getAllExpensesToday();
      extraController.getAllDriversExtras();
      checkTheTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SlideInUp(
          animate: true,
          child: ListView(
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
                            return Text("${controller.username.toString().capitalize} DashBoard",style:const TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 20),);
                          })
                          ,
                          const SizedBox(height:20),
                          Row(
                            children: [
                              IconButton(
                                onPressed: (){
                                  Get.to(() => const SearchPage());
                                },
                                icon: const Icon(Icons.search, size:30, color:Colors.white),
                              ),
                              const SizedBox(width: 110),
                              GestureDetector(
                                onTap: (){
                                  Get.to(()=> const AllUsers());
                                },
                                  child: Image.asset("assets/images/group.png",width:40,height:40,fit: BoxFit.cover,)),
                              // TextButton(
                              //   onPressed: () {
                              //     sendSms.sendMySms("+233593380008", "Taxinet",
                              //         "All cars are locked successfully.");
                              //     for(var i in driversTrackingNumbers){
                              //       sendSms.sendMySms(i, "0244529353", "relay,1\%23#");
                              //     }
                              //     for(var i in driversNumbers){
                              //       sendSms.sendMySms(i, "Taxinet", "Attention!,your car is locked.");
                              //     }
                              //   },
                              //   child:const Text("Hi")
                              // )
                            ],
                          )
                        ],
                      )
                    ],
                  )
              ),
              const SizedBox(height:10),
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
                            height:130,
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
                          Get.to(() => const Investors());
                        },
                        child: Card(
                          elevation: 12,
                          child: Container(
                            height:130,
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
              const SizedBox(height: 10,),
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
                            height:130,
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
                            height:130,
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
              const SizedBox(height: 10,),
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
                            height:130,
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
                          Get.to(() => const Expenses());
                        },
                        child: Card(
                          elevation: 12,
                          child: Container(
                            height:130,
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
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left:18.0,right:18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Get.to(() => const AllWallets());
                        },
                        child: Card(
                          elevation: 12,
                          child: Container(
                            height:130,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/wallet.png",width:42),
                                  const SizedBox(height:20),
                                  const Text("Wallets",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),)
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
                          Get.to(() => const Registration());
                        },
                        child: Card(
                          elevation: 12,
                            child: Container(
                              height:130,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/register.png",width:42),
                                    const SizedBox(height:20),
                                    const Text("Register User",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),)
                                  ]
                              ),
                            ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left:18.0,right:18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Get.to(() => const DriversForInspection());
                        },
                        child: Card(
                          elevation: 12,
                          child: Container(
                            height:130,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/inspection.png",width:42),
                                  const SizedBox(height:20),
                                  const Text("Inspection",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),)
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
                          Get.to(() => const AllDriversExtras());
                        },
                        child: Card(
                          elevation: 12,
                          child: Container(
                            height:130,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/extra.png",width:42),
                                  const SizedBox(height:20),
                                  const Text("Driver's Extra",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),)
                                ]
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}