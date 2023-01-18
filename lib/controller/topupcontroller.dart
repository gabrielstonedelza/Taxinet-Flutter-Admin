import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class TopUpController extends GetxController{
  bool isLoading = true;
  final storage = GetStorage();
  var username = "";
  String uToken = "";
  List allTopUpRequests = [];



  Future<void> getAllTopUps() async {
    try {
      isLoading = true;
      update();
      const walletUrl = "https://taxinetghana.xyz/get_all_request_top_up/";
      var link = Uri.parse(walletUrl);
      http.Response response = await http.get(link, headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      });
      if (response.statusCode == 200) {
        if (kDebugMode) {
          // print(response.body);
        }
        var jsonData = jsonDecode(response.body);
        allTopUpRequests = jsonData;
        update();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading = false;
      update();
    }
  }

}