import 'package:flutter/foundation.dart';
import "package:get/get.dart";
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class VehiclesController extends GetxController{
  List vehicles = [];
  bool isLoading = true;

  Future<void> getAllVehicles() async {
    try {
      isLoading = true;
      const walletUrl = "https://taxinetghana.xyz/all_vehicles/";
      var link = Uri.parse(walletUrl);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      });
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        vehicles.assignAll(jsonData);
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

}