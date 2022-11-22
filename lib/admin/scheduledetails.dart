import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import "package:flutter/material.dart";

import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:taxinet_admin/admin/updaterequest.dart';

import '../../constants/app_colors.dart';
import "package:get/get.dart";

import '../controller/requestscontroller.dart';
import 'assigndriver.dart';


enum PaymentMethodEnum { wallet, cash }

class ScheduleDetail extends StatefulWidget {
  final title;
  final id;
  const ScheduleDetail(
      {Key? key,required this.title, required this.id})
      : super(key: key);

  @override
  State<ScheduleDetail> createState() => _ScheduleDetailState(

    title: this.title,
    id: this.id,
  );
}

class _ScheduleDetailState extends State<ScheduleDetail> {

  final title;
  final id;
  _ScheduleDetailState(
      { required this.title, required this.id});
  bool isPosting = false;
  bool isStartingTrip = false;
  bool isEndingTrip = false;
  final storage = GetStorage();
  var username = "";
  String uToken = "";
  String passengerId = "";
  String driversId = "";
  String assignedDriver = "";
  String passengerWithSchedule = "";
  String passengerPic = "";
  String driversPic = "";
  String passengerPhoneNumber = "";
  String scheduleType = "";
  String schedulePriority = "";
  String rideType = "";
  String pickUpLocation = "";
  String dropOffLocation = "";
  String pickUpTime = "";
  String startDate = "";
  String status = "";
  String dateRequested = "";
  String timeRequested = "";
  String description = "";
  String price = "";
  String scheduleRideId = "";
  String charge = "";

  bool isLoading = true;


  RequestController controller = Get.find();

  Future<void> getDetailSchedule() async {
    final walletUrl = "https://taxinetghana.xyz/admin_request_detail/$id/";
    var link = Uri.parse(walletUrl);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    if (response.statusCode == 200) {
      final codeUnits = response.body;
      var jsonData = jsonDecode(codeUnits);
      driversId = jsonData['assigned_driver'].toString();
      assignedDriver = jsonData['get_assigned_driver_name'];
      // driversPic = jsonData['get_assigned_driver_profile_pic'];
      passengerWithSchedule = jsonData['get_passenger_name'];
      // passengerPic = jsonData['get_passenger_profile_pic'];
      scheduleType = jsonData['schedule_type'];
      rideType = jsonData['ride_type'];
      pickUpLocation = jsonData['pickup_location'];
      dropOffLocation = jsonData['drop_off_location'];
      pickUpTime = jsonData['pick_up_time'];
      startDate = jsonData['start_date'];
      status = jsonData['status'];
      dateRequested = jsonData['date_scheduled'];
      timeRequested = jsonData['time_scheduled'];
      price = jsonData['price'];
      charge = jsonData['charge'];
      passengerId = jsonData['passenger'].toString();
      passengerPhoneNumber = jsonData['get_passenger_number'];
      scheduleRideId = jsonData['id'].toString();
    }
    else{
      if (kDebugMode) {
        print(response.body);
      }
    }
    setState(() {
      isLoading = false;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (storage.read("userToken") != null) {
      uToken = storage.read("userToken");
    }
    if (storage.read("username") != null) {
      username = storage.read("username");
    }
    getDetailSchedule();
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          title: Text(title, style: const TextStyle(color: defaultTextColor2)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back, color: defaultTextColor2)),
        ),
        body: isLoading ? const Center(
          child:CircularProgressIndicator.adaptive(
            strokeWidth: 5,
            backgroundColor: primaryColor,
          )
        ) :ListView(
          children: [
            const SizedBox(height: 10),
             Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Card(
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Get.to(()=> UpdateRequest(passenger:passengerId,ride:scheduleRideId,title:title,price:price,charge:charge, ));
                                      },
                                      child: const Text("Update")
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.to(()=> AssignDriver(driver:driversId,ride:scheduleRideId,title:title,assignedDriver:assignedDriver,passenger:passengerId));
                                      },
                                      child: const Text("Assign Driver")
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        showMaterialModalBottomSheet(
                                          context: context,
                                          isDismissible: true,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.vertical(
                                                  top: Radius.circular(25.0))),
                                          bounce: true,
                                          builder: (context) => SingleChildScrollView(
                                            controller: ModalScrollController.of(context),
                                            child: SizedBox(
                                                height: 250,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(18.0),
                                                  child:
                                                  Column(
                                                    children: [
                                                      const SizedBox(height:20),
                                                      Text("$title is already assigned to $assignedDriver",style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                                      const SizedBox(height:20),
                                                      Text("You are about to remove $assignedDriver and set to default which is the admin."),
                                                      const SizedBox(height:20),
                                                      RawMaterialButton(
                                                        onPressed: () {
                                                          controller.handleUnAssignToDriver(scheduleRideId,passengerId);
                                                          Get.snackbar("Success", "you have set the default to admin,it will take at least two minutes to take effect",
                                                              duration: const Duration(seconds: 5),
                                                              snackPosition: SnackPosition.BOTTOM,
                                                              backgroundColor: Colors.black,
                                                              colorText: defaultTextColor1);
                                                          setState(() {});
                                                          Navigator.pop(context);
                                                        },
                                                        // child: const Text("Send"),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                8)),
                                                        elevation: 8,
                                                        fillColor:
                                                        primaryColor,
                                                        splashColor:
                                                        defaultColor,
                                                        child: const Padding(
                                                          padding: EdgeInsets.all(10.0),
                                                          child: Text(
                                                            "UnAssign",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontSize: 20,
                                                                color:
                                                                defaultTextColor1),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                            ),
                                          ),
                                        );

                                      },
                                      child: const Text("UnAssign Driver",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.red))
                                  ),
                                ],
                              ),
                            ]),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              // passenger profile pic,name and alert arrival button
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [

                                      Text(
                                          "${assignedDriver.toString().capitalize}",
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 15)),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      const Text(
                                          "Driver",
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 15)),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Divider(),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [

                                      Text(
                                          "${passengerWithSchedule.toString().capitalize}",
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 15)),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      const Text(
                                          "Passenger",
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold,
                                              fontSize: 15)),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                ],
                              ),
                            ]),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Passengers Phone",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              const SizedBox(height: 10),
                              Text(passengerPhoneNumber)
                            ]),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Schedule Type",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              const SizedBox(height: 10),
                              Text(scheduleType)
                            ]),

                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Ride Type",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              const SizedBox(height: 10),
                              Text(rideType)
                            ]),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Pickup Location",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              const SizedBox(height: 10),
                              Text(pickUpLocation)
                            ]),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Drop Off Location",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              const SizedBox(height: 10),
                              Text(dropOffLocation)
                            ]),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Pick up time",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              const SizedBox(height: 10),
                              Text(pickUpTime)
                            ]),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Start Date",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              const SizedBox(height: 10),
                              Text(startDate)
                            ]),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Status",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              const SizedBox(height: 10),
                              Text(status)
                            ]),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Date Requested",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              const SizedBox(height: 10),
                              Text(dateRequested)
                            ]),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Time Requested",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              const SizedBox(height: 10),
                              Text(timeRequested
                                  .toString()
                                  .split(".")
                                  .first)
                            ]),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Price",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              const SizedBox(height: 10),
                              Text(price)
                            ]),
                        const SizedBox(height: 10),
                        const Divider(),
                        const SizedBox(height: 10),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Charge",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              const SizedBox(height: 10),
                              Text(charge)
                            ]),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
