import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:get/get.dart";
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:taxinet_admin/admin/scheduledetails.dart';
import '../constants/app_colors.dart';
import '../controller/walletcontroller.dart';

class SearchRequests extends StatefulWidget {
  const SearchRequests({Key? key}) : super(key: key);

  @override
  State<SearchRequests> createState() => _SearchRequestsState();
}

class _SearchRequestsState extends State<SearchRequests> {
  final WalletController controller = Get.find();
  var items;
  late List rideUsers = [];
  bool isSearching = false;

  searchRideRequest(String searchItem)async{
    final url = "https://taxinetghana.xyz/search_ride_request?search=$searchItem";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink);

    if(response.statusCode ==200){
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      rideUsers = json.decode(jsonData);
    }
    else{

    }

    setState(() {
      // isSearching = false;
      rideUsers = rideUsers;
    });
  }

  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor:Colors.transparent,
          elevation:0,
          title: const Text("Search Ride Request",),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon:const Icon(Icons.arrow_back,color:defaultTextColor2)
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value){
                  if(value.isNotEmpty){
                    setState(() {
                      isSearching = true;
                    });
                    searchRideRequest(value);
                  }
                  if(value.isEmpty){
                    setState(() {
                      isSearching = false;
                    });
                  }

                },
                style: const TextStyle(color:defaultTextColor1),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: defaultColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide:BorderSide.none,

                  ),
                  hintText:  "eg: username, phone number",
                  prefixIcon: const Icon(Icons.search,color:Colors.white),
                  prefixIconColor: Colors.white,
                ),
              ),
              const SizedBox (height:20),
              Expanded(
                  child: isSearching ? rideUsers.length == 0 ? const Text("No results found",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: defaultTextColor1),): ListView.builder(
                      itemCount: rideUsers != null ? rideUsers.length : 0,
                      itemBuilder: (context,index){
                        items = rideUsers[index];
                        return SlideInUp(
                          animate: true,
                          child: Card(
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              onTap: (){
                                Get.to(()=> ScheduleDetail(slug:rideUsers[index]['slug'],title:rideUsers[index]['schedule_title'],id:rideUsers[index]['id'].toString()));
                              },
                              title: Padding(
                                padding: const EdgeInsets.only(bottom:10.0,top:10),
                                child: Text(items['schedule_title']),
                              ),
                              subtitle: Text(items['date_scheduled']),
                            ),
                          ),
                        );
                      }
                  ) : Container()
              )
            ],
          ),
        )
    );
  }
}
