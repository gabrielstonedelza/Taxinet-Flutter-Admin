import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:taxinet_admin/admin/scheduledetails.dart';
import '../../../constants/app_colors.dart';
import '../controller/requestscontroller.dart';




class AllRequests extends StatefulWidget {
  const AllRequests({Key? key}) : super(key: key);

  @override
  State<AllRequests> createState() => _AllRequestsState();
}

class _AllRequestsState extends State<AllRequests> {

  RequestController scheduleController = Get.find();


  final storage = GetStorage();

  late String username = "";

  late String uToken = "";

  late String userid = "";

  var items;

  bool isFetching = true;

  bool isLoading = true;
  late Timer _timer;


  @override
  void initState() {
    super.initState();

    // ignore: todo
    // TODO: implement initState
    if (storage.read("userToken") != null) {
      uToken = storage.read("userToken");
    }
    if (storage.read("username") != null) {
      username = storage.read("username");
    }
    if (storage.read("userid") != null) {
      userid = storage.read("userid");
    }

    scheduleController.getActiveSchedules();
    scheduleController.getAllSchedules();
    scheduleController.getOneTimeSchedules();
    scheduleController.getDailySchedules();
    scheduleController.getDaysSchedules();
    scheduleController.getWeeklySchedules();

    _timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      scheduleController.getActiveSchedules();
      scheduleController.getAllSchedules();
      scheduleController.getOneTimeSchedules();
      scheduleController.getDailySchedules();
      scheduleController.getDaysSchedules();
      scheduleController.getWeeklySchedules();
    });
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.transparent,
          elevation:0,
          title: const Text("Schedules"),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon:const Icon(Icons.arrow_back,color:defaultTextColor2)
          ),
        ),
        backgroundColor: primaryColor,
        body:  ListView(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32)),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    const SizedBox(height: 30,),
                    SlideInUp(
                      animate: true,
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          showMaterialModalBottomSheet(
                                            context: context,
                                            isDismissible: true,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.vertical(
                                                    top: Radius.circular(
                                                        25.0))),
                                            bounce: true,
                                            builder: (context) => SingleChildScrollView(
                                              controller: ModalScrollController.of(context),
                                              child: SizedBox(
                                                  height: 600,
                                                  child: ListView.builder(
                                                      itemCount: scheduleController.activeSchedules != null ? scheduleController.activeSchedules.length : 0,
                                                      itemBuilder: (context,index){
                                                        items = scheduleController.activeSchedules[index];
                                                        return Padding(
                                                          padding: const EdgeInsets.only(left: 10, right: 10,),
                                                          child: SlideInUp(
                                                            animate: true,
                                                            child: Card(
                                                                elevation: 12,
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(12),
                                                                ),
                                                                child: ListTile(
                                                                    onTap: (){
                                                                      Get.to(()=> ScheduleDetail(slug:scheduleController.activeSchedules[index]['slug'],title:scheduleController.activeSchedules[index]['schedule_title'],id:scheduleController.allSchedules[index]['id'].toString()));
                                                                    },
                                                                    leading: const Icon(Icons.access_time_filled),
                                                                    title: Text(items['schedule_title'],style:const TextStyle(fontWeight: FontWeight.bold)),
                                                                    subtitle: Padding(
                                                                      padding: const EdgeInsets.only(top:10.0),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(bottom:8.0),
                                                                            child: Text(items['ride_type']),
                                                                          ),

                                                                          Text(items['date_scheduled']),
                                                                        ],
                                                                      ),
                                                                    )
                                                                )
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                  )
                                              ),
                                            ),
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Container(
                                            color: greyBack,
                                            height: 85,
                                            width: 200,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Icon(FontAwesomeIcons.fire,color: primaryColor,),
                                                      GetBuilder<RequestController>(builder: (controller){
                                                        return Text("${scheduleController.activeSchedules.length}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: pearl),);
                                                      })
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  const Text("Active",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: pearl),)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20,),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: (){
                                          showMaterialModalBottomSheet(
                                            context: context,
                                            isDismissible: true,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.vertical(
                                                    top: Radius.circular(
                                                        25.0))),
                                            bounce: true,
                                            builder: (context) => SingleChildScrollView(
                                              controller: ModalScrollController.of(context),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                      height: 600,
                                                      child:  ListView.builder(
                                                          itemCount: scheduleController.allOneTimeSchedules != null ? scheduleController.allOneTimeSchedules.length : 0,
                                                          itemBuilder: (context,index){
                                                            items = scheduleController.allOneTimeSchedules[index];
                                                            return Padding(
                                                              padding: const EdgeInsets.only(left: 10, right: 10,),
                                                              child: SlideInUp(
                                                                animate: true,
                                                                child: Card(
                                                                    elevation: 12,
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(12),
                                                                    ),
                                                                    child: ListTile(
                                                                        onTap: (){
                                                                          Get.to(()=> ScheduleDetail(slug:scheduleController.allOneTimeSchedules[index]['slug'],title:scheduleController.allOneTimeSchedules[index]['schedule_title'],id:scheduleController.allSchedules[index]['id'].toString()));
                                                                          // Navigator.pop(context);
                                                                        },
                                                                        leading: const Icon(Icons.access_time_filled),
                                                                        title: Text(items['schedule_title'],style:const TextStyle(fontWeight: FontWeight.bold)),
                                                                        subtitle: Padding(
                                                                          padding: const EdgeInsets.only(top:10.0),
                                                                          child: Text(items['date_scheduled']),
                                                                        )
                                                                    )
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Container(
                                            color: greyBack,
                                            height: 85,
                                            width: 200,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Icon(FontAwesomeIcons.fire,color: primaryColor,),
                                                      GetBuilder<RequestController>(builder: (controller){
                                                        return Text("${scheduleController.allOneTimeSchedules.length}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: pearl),);
                                                      })
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  const Text("One Time",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: pearl),)
                                                ],
                                              ),
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
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          showMaterialModalBottomSheet(
                                            context: context,
                                            isDismissible: true,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.vertical(
                                                    top: Radius.circular(
                                                        25.0))),
                                            bounce: true,
                                            builder: (context) => SingleChildScrollView(
                                              controller: ModalScrollController.of(context),
                                              child: SizedBox(
                                                  height: 600,
                                                  child: ListView.builder(
                                                      itemCount: scheduleController.allDailySchedules != null ? scheduleController.allDailySchedules.length : 0,
                                                      itemBuilder: (context,index){
                                                        items = scheduleController.allDailySchedules[index];
                                                        return Padding(
                                                          padding: const EdgeInsets.only(left: 10, right: 10,),
                                                          child: SlideInUp(
                                                            animate: true,
                                                            child: Card(
                                                                elevation: 12,
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(12),
                                                                ),
                                                                child: ListTile(
                                                                    onTap: (){
                                                                      Get.to(()=> ScheduleDetail(slug:scheduleController.allDailySchedules[index]['slug'],title:scheduleController.allDailySchedules[index]['schedule_title'],id:scheduleController.allSchedules[index]['id'].toString()));
                                                                    },
                                                                    leading: const Icon(Icons.access_time_filled),
                                                                    title: Text(items['schedule_title'],style:const TextStyle(fontWeight: FontWeight.bold)),
                                                                    subtitle: Padding(
                                                                      padding: const EdgeInsets.only(top:10.0),
                                                                      child: Text(items['date_scheduled']),
                                                                    )
                                                                )
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                  )
                                              ),
                                            ),
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Container(
                                            color: greyBack,
                                            height: 85,
                                            width: 200,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Icon(FontAwesomeIcons.fire,color: primaryColor,),
                                                      GetBuilder<RequestController>(builder: (_){
                                                        return Text("${scheduleController.allDailySchedules.length}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: pearl),);
                                                      })

                                                    ],
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  const Text("Daily",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: pearl),)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20,),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          showMaterialModalBottomSheet(
                                            context: context,
                                            isDismissible: true,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.vertical(
                                                    top: Radius.circular(
                                                        25.0))),
                                            bounce: true,
                                            builder: (context) => SingleChildScrollView(
                                              controller: ModalScrollController.of(context),
                                              child: SizedBox(
                                                  height: 600,
                                                  child: ListView.builder(
                                                      itemCount: scheduleController.allDaysSchedules != null ? scheduleController.allDaysSchedules.length : 0,
                                                      itemBuilder: (context,index){
                                                        items = scheduleController.allDaysSchedules[index];
                                                        return Padding(
                                                          padding: const EdgeInsets.only(left: 10, right: 10,),
                                                          child: SlideInUp(
                                                            animate: true,
                                                            child: Card(
                                                                elevation: 12,
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(12),
                                                                ),
                                                                child: ListTile(
                                                                    onTap: (){
                                                                      Get.to(()=> ScheduleDetail(slug:scheduleController.allDaysSchedules[index]['slug'],title:scheduleController.allDaysSchedules[index]['schedule_title'],id:scheduleController.allSchedules[index]['id'].toString()));
                                                                    },
                                                                    leading: const Icon(Icons.access_time_filled),
                                                                    title: Text(items['schedule_title'],style:const TextStyle(fontWeight: FontWeight.bold)),
                                                                    subtitle: Padding(
                                                                      padding: const EdgeInsets.only(top:10.0),
                                                                      child: Text(items['date_scheduled']),
                                                                    )
                                                                )
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                  )
                                              ),
                                            ),
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Container(
                                            color: greyBack,
                                            height: 85,
                                            width: 200,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Icon(FontAwesomeIcons.fire,color: primaryColor,),
                                                      GetBuilder<RequestController>(builder: (_){
                                                        return Text("${scheduleController.allDaysSchedules.length}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: pearl),);
                                                      })
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  const Text("Days",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: pearl),)
                                                ],
                                              ),
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
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: (){
                                          showMaterialModalBottomSheet(
                                            context: context,
                                            isDismissible: true,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.vertical(
                                                    top: Radius.circular(
                                                        25.0))),
                                            bounce: true,
                                            builder: (context) => SingleChildScrollView(
                                              controller: ModalScrollController.of(context),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                      height: 600,
                                                      child:  ListView.builder(
                                                          itemCount: scheduleController.allWeeklySchedules != null ? scheduleController.allWeeklySchedules.length : 0,
                                                          itemBuilder: (context,index){
                                                            items = scheduleController.allWeeklySchedules[index];
                                                            return Padding(
                                                              padding: const EdgeInsets.only(left: 10, right: 10,),
                                                              child: SlideInUp(
                                                                animate: true,
                                                                child: Card(
                                                                    elevation: 12,
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(12),
                                                                    ),
                                                                    child: ListTile(
                                                                        onTap: (){
                                                                          Get.to(()=> ScheduleDetail(slug:scheduleController.allWeeklySchedules[index]['slug'],title:scheduleController.allWeeklySchedules[index]['schedule_title'],id:scheduleController.allSchedules[index]['id'].toString()));
                                                                          // Navigator.pop(context);
                                                                        },
                                                                        leading: const Icon(Icons.access_time_filled),
                                                                        title: Text(items['schedule_title'],style:const TextStyle(fontWeight: FontWeight.bold)),
                                                                        subtitle: Padding(
                                                                          padding: const EdgeInsets.only(top:10.0),
                                                                          child: Text(items['date_scheduled']),
                                                                        )
                                                                    )
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Container(
                                            color: greyBack,
                                            height: 85,
                                            width: 200,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Icon(FontAwesomeIcons.fire,color: primaryColor,),
                                                      GetBuilder<RequestController>(builder: (_){
                                                        return Text("${scheduleController.allWeeklySchedules.length}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: pearl),);
                                                      })
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  const Text("Weekly",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: pearl),)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20,),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: (){
                                          showMaterialModalBottomSheet(
                                            context: context,
                                            isDismissible: true,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.vertical(
                                                    top: Radius.circular(
                                                        25.0))),
                                            bounce: true,
                                            builder: (context) => SingleChildScrollView(
                                              controller: ModalScrollController.of(context),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                      height: 600,
                                                      child:  ListView.builder(
                                                          itemCount: scheduleController.allMonthlySchedules != null ? scheduleController.allMonthlySchedules.length : 0,
                                                          itemBuilder: (context,index){
                                                            items = scheduleController.allMonthlySchedules[index];
                                                            return Padding(
                                                              padding: const EdgeInsets.only(left: 10, right: 10,),
                                                              child: SlideInUp(
                                                                animate: true,
                                                                child: Card(
                                                                    elevation: 12,
                                                                    shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(12),
                                                                    ),
                                                                    child: ListTile(
                                                                        onTap: (){
                                                                          Get.to(()=> ScheduleDetail(slug:scheduleController.allMonthlySchedules[index]['slug'],title:scheduleController.allMonthlySchedules[index]['schedule_title'],id:scheduleController.allSchedules[index]['id'].toString()));
                                                                          // Navigator.pop(context);
                                                                        },
                                                                        leading: const Icon(Icons.access_time_filled),
                                                                        title: Text(items['schedule_title'],style:const TextStyle(fontWeight: FontWeight.bold)),
                                                                        subtitle: Padding(
                                                                          padding: const EdgeInsets.only(top:10.0),
                                                                          child: Text(items['date_scheduled']),
                                                                        )
                                                                    )
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: Container(
                                            color: greyBack,
                                            height: 85,
                                            width: 200,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      const Icon(FontAwesomeIcons.fire,color: primaryColor,),
                                                      GetBuilder<RequestController>(builder: (_){
                                                        return Text("${scheduleController.allWeeklySchedules.length}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: pearl),);
                                                      })
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  const Text("Monthly",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: pearl),)
                                                ],
                                              ),
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
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}
