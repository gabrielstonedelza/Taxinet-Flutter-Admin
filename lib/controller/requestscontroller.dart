import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';

import '../constants/app_colors.dart';


class RequestController extends GetxController{
  bool isLoading = true;
  final storage = GetStorage();
  var username = "";
  String uToken = "";
  List activeSchedules = [];
  List allSchedules = [];
  List allShortTripsSchedules = [];
  List allDailySchedules = [];
  List allWeeklySchedules = [];
  List allDaysSchedules = [];
  List allMonthlySchedules = [];
  List detailScheduleItems = [];
  List allDrivers = [];
  late List allPassengers = [];
  List allAssignedDrivers = [];
  late List allInvestors = [];
  bool rideStarted = false;
  late List allUsers = [];
  late List allBlockedUsers = [];


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (storage.read("userToken") != null) {
      uToken = storage.read("userToken");
    }
    if (storage.read("username") != null) {
      username = storage.read("username");
    }
  }

  fetchUsers()async{
    const url = "https://taxinetghana.xyz/all_users/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink);

    if(response.statusCode ==200){
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      allUsers = json.decode(jsonData);
      update();
    }

  }
  fetchBlockedUsers()async{
    const url = "https://taxinetghana.xyz/get_all_blocked_users/";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink,);

    if(response.statusCode ==200){
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      allBlockedUsers = json.decode(jsonData);
      update();
    }

  }
//
  Future<void> getActiveSchedules() async {
    try {
      isLoading = true;
      const walletUrl = "https://taxinetghana.xyz/admin_get_active_schedules/";
      var link = Uri.parse(walletUrl);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",

      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        activeSchedules.assignAll(jsonData);

        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
    }
  }

  Future<void> getAllSchedules() async {
    try {
      isLoading = true;
      const walletUrl = "https://taxinetghana.xyz/admin_get_all_requests/";
      var link = Uri.parse(walletUrl);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allSchedules.assignAll(jsonData);
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
    }
  }

  //drivers schedules by types
  Future<void> getShortTripSchedules() async {
    try {
      isLoading = true;
      const walletUrl = "https://taxinetghana.xyz/admin_get_scheduled_for_short_trips/";
      var link = Uri.parse(walletUrl);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",

      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allShortTripsSchedules.assignAll(jsonData);
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
    }
  }
  Future<void> getDailySchedules() async {
    try {
      isLoading = true;
      const walletUrl = "https://taxinetghana.xyz/admin_get_scheduled_for_daily/";
      var link = Uri.parse(walletUrl);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allDailySchedules.assignAll(jsonData);
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
    }
  }
  Future<void> getDaysSchedules() async {
    try {
      isLoading = true;
      const walletUrl = "https://taxinetghana.xyz/admin_get_scheduled_for_days/";
      var link = Uri.parse(walletUrl);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",

      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allDaysSchedules.assignAll(jsonData);
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
    }
  }
  Future<void> getWeeklySchedules() async {
    try {
      isLoading = true;
      const walletUrl = "https://taxinetghana.xyz/admin_get_scheduled_for_weekly/";
      var link = Uri.parse(walletUrl);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allWeeklySchedules.assignAll(jsonData);
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
    }
  }

  Future<void> getAllDrivers() async {
    try {
      isLoading = true;
      const walletUrl = "https://taxinetghana.xyz/all_drivers_profile/";
      var link = Uri.parse(walletUrl);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allDrivers.assignAll(jsonData);
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
    }
  }

  Future<void> getAllPassengers() async {
    try {
      isLoading = true;
      const profileLink = "https://taxinetghana.xyz/all_passengers_profile/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allPassengers = jsonData;
        update();
      }
      else{
        if (kDebugMode) {
          print(response.body);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
    }
  }

  Future<void> getAllInvestors() async {
    try {
      isLoading = true;
      const profileLink = "https://taxinetghana.xyz/all_investors_profile/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allInvestors = jsonData;
        update();

      }
      else{
        if (kDebugMode) {
          print(response.body);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
    }
  }

  Future<void> getAllAssignedDrivers() async {
    try {
      isLoading = true;
      const walletUrl = "https://taxinetghana.xyz/admin_get_all_assigned_drivers/";
      var link = Uri.parse(walletUrl);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allAssignedDrivers.assignAll(jsonData);
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
    }
  }

  handleAddToAssignedDrivers(String driver,String ride) async {
    const loginUrl = "https://taxinetghana.xyz/admin_assign_request_to_driver/";
    final handleAdminUrl = Uri.parse(loginUrl);

    http.Response response = await http.post(handleAdminUrl,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {"driver": driver, "ride": ride});

    if (response.statusCode == 201) {
      final resBody = response.body;


    }
    else{

      Get.snackbar("Sorry 😢", "Something went wrong",
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: defaultTextColor1);
      return;
    }
  }

  handleAssignToDriver(String driver,String passenger,String ride) async {
    handleAddToAssignedDrivers(driver,ride);
    final loginUrl = "https://taxinetghana.xyz/admin_update_requested_ride/$ride/";
    final handleAdminUrl = Uri.parse(loginUrl);

    http.Response response = await http.put(handleAdminUrl,
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {
          "assigned_driver": driver,
          "ride": ride,
          "passenger" : passenger
    });

    if (response.statusCode == 200) {
      Get.back();
    }
  }

  handleUnAssignToDriver(String ride,String passenger) async {
    final loginUrl = "https://taxinetghana.xyz/admin_update_requested_ride/$ride/";
    final handleAdminUrl = Uri.parse(loginUrl);

    http.Response response = await http.put(handleAdminUrl,
        headers: {
      "Content-Type": "application/json"
        },
        body: jsonEncode({
          "assigned_driver": 1,
          "ride": ride,
          "passenger":passenger
    }));

    if (response.statusCode == 200) {

    }
  }

}