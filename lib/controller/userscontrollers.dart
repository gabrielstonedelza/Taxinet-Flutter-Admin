import 'package:flutter/foundation.dart';
import "package:get/get.dart";
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class UsersController extends GetxController{
  late List allUsers = [];
  late List phoneNumbers = [];
  late List driversUniqueCodes = [];
  late List allDrivers = [];
  late List driversNames = [];
  late List passengerNames = [];
  late List passengersUniqueCodes = [];
  late List allPassengers = [];
  late List allInvestors = [];
  bool isLoading = true;

  Future<void> getAllUsers(String token) async {
    try {
      isLoading = true;
      const profileLink = "https://taxinetghana.xyz/users/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Token $token"
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allUsers = jsonData;
        for (var i in allUsers) {
          if(!phoneNumbers.contains(i['phone_number'])){
            phoneNumbers.add(i['phone_number']);
          }
        }
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

  Future<void> getAllDrivers() async {
    try {
      isLoading = true;
      const profileLink = "https://taxinetghana.xyz/all_drivers_profile/";
      var link = Uri.parse(profileLink);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        allDrivers.assignAll(jsonData);
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

}