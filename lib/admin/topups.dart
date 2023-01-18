import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../constants/app_colors.dart';
import '../controller/requestscontroller.dart';
import '../controller/topupcontroller.dart';

class AllTopUps extends StatefulWidget {
  const AllTopUps({Key? key}) : super(key: key);

  @override
  State<AllTopUps> createState() => _AllTopUpsState();
}

class _AllTopUpsState extends State<AllTopUps> {
  final TopUpController controller = Get.find();
  var items;

  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor:Colors.transparent,
          elevation:0,
          title: const Text("Top Up Requests",),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon:const Icon(Icons.arrow_back,color:defaultTextColor2)
          ),
        ),
        body: ListView.builder(
          itemCount: controller.allTopUpRequests != null ? controller.allTopUpRequests.length : 0,
          itemBuilder: (BuildContext context, int index) {
            items = controller.allTopUpRequests[index];
            return Card(
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: Text(items['get_username']),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(items['amount']),
                    Text(items['date_requested']),
                    Text(items['time_requested'].toString().split(".").first),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
