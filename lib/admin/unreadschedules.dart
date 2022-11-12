import 'package:animate_do/animate_do.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:taxinet_admin/admin/scheduledetails.dart';
import 'package:taxinet_admin/admin/searchrequests.dart';
import 'package:taxinet_admin/controller/requestscontroller.dart';

import '../constants/app_colors.dart';
import 'allrequests.dart';

class AllUnReadSchedules extends StatefulWidget {
  const AllUnReadSchedules({Key? key}) : super(key: key);

  @override
  State<AllUnReadSchedules> createState() => _AllUnReadSchedulesState();
}

class _AllUnReadSchedulesState extends State<AllUnReadSchedules> {

  final RequestController controller = Get.find();
  var items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:primaryColor,
      appBar: AppBar(
        backgroundColor:Colors.transparent,
        elevation:0,
        title: const Text("Schedules"),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon:const Icon(Icons.arrow_back,color:defaultTextColor1)
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(()=> const SearchRequests());
              },
              icon:const Icon(Icons.search,color:defaultTextColor2)
          )
        ],
      ),
      body: GetBuilder<RequestController>(builder:(controller){
        return ListView.builder(
          itemCount: controller.allSchedules != null ? controller.allSchedules.length : 0,
          itemBuilder: (BuildContext context, int index) {
            items = controller.allSchedules[index];
            return Column(
              children: [
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: SlideInUp(
                    animate: true,
                    child: items['read'] == "Not Read" ? Card(
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading:Image.asset("assets/images/clock.png",width:40,height: 40),
                        title: Text(items['get_passenger_name'],style:const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top:10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(items['status']),
                              const SizedBox(height: 10,),
                              Text(items['date_scheduled']),
                            ],
                          ),
                        ),
                        onTap: (){

                          Get.to(()=> ScheduleDetail(title:controller.allSchedules[index]['get_passenger_name'],id:controller.allSchedules[index]['id'].toString()));
                        },
                      ),
                    ) : Container(),
                  ),
                )
              ],
            );
          },

        );
      }),
      floatingActionButton:FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: (){
          Get.to(() => const AllRequests());
        },
        child: const Icon(Icons.access_time_filled)
      )
    );
  }
}
