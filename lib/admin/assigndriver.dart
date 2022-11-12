import 'package:animate_do/animate_do.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../constants/app_colors.dart';
import '../controller/requestscontroller.dart';

class AssignDriver extends StatefulWidget {

  final driver;
  final ride;
  final title;
  final assignedDriver;
  final passenger;
  const AssignDriver({Key? key,required this.driver,required this.ride,required this.title,required this.assignedDriver,required this.passenger}) : super(key: key);

  @override
  State<AssignDriver> createState() => _AssignDriverState( driver:this.driver,ride:this.ride,title:this.title,assignedDriver:this.assignedDriver,passenger:this.passenger);
}

class _AssignDriverState extends State<AssignDriver> {
  final driver;
  final ride;
  final title;
  final assignedDriver;
  final passenger;
  _AssignDriverState({required this.driver,required this.ride,required this.title,required this.assignedDriver,required this.passenger});
  final RequestController controller = Get.find();
  var items;
  var items2;

  @override
  void initState(){
    super.initState();
    print(driver);
    // print(controller.allDrivers);
    // print(controller.allAssignedDrivers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Assign driver to $title", style: const TextStyle(color: defaultTextColor2,fontSize: 15)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back, color: defaultTextColor2)),
        ),
      body: ListView.builder(
        itemCount: controller.allSchedules != null ? controller.allSchedules.length : 0,
        itemBuilder: (BuildContext context, int index) {
          items = controller.allSchedules[index];
          return SlideInUp(
            animate: true,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: controller.allDrivers != null ? controller.allDrivers.length : 0,
                itemBuilder: (BuildContext context, int index) {
                  items2 = controller.allDrivers[index];
                  return Card(
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      onTap: (){
                        // print(controller.allDrivers[index]['user']);
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
                                  child: int.parse(driver)  == controller.allDrivers[index]['user'] ? Column(
                                    children: [
                                      const SizedBox(height:20),
                                      Text("$assignedDriver is already assigned to $title",style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                      const SizedBox(height:20),
                                      Text("Click on any other driver to remove $assignedDriver as the assignedDriver and set the driver as the assignedDriver."),
                                    ],
                                  ) :
                                  Column(
                                    children: [
                                      const SizedBox(height:20),
                                      Text("$title is already assigned to $assignedDriver",style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                                      const SizedBox(height:20),
                                      Text("By clicking on assign, you are removing $assignedDriver as the assigned driver and setting ${controller.allDrivers[index]['username']} as the new assigned driver"),
                                      const SizedBox(height:20),
                                      RawMaterialButton(
                                        onPressed: () {
                                          controller.handleAssignToDriver(controller.allDrivers[index]['user'].toString(),passenger,ride);
                                          Get.snackbar("Hurray", "${controller.allDrivers[index]['username']} is now the assigned driver.Please wait for at least two for this to take effect",
                                              duration: const Duration(seconds: 8),
                                              snackPosition: SnackPosition.BOTTOM,
                                              backgroundColor: primaryColor,
                                              colorText: defaultTextColor2);
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
                                        child: const Text(
                                          "Assign",
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight
                                                  .bold,
                                              fontSize: 20,
                                              color:
                                              defaultTextColor1),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            ),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(items2['driver_profile_pic']),
                      ),
                      title: Text(items2['get_drivers_full_name']),
                      subtitle: Text(items2['username']),
                      trailing: int.parse(driver)  == controller.allDrivers[index]['user'] ? Image.asset("assets/images/taxi-driver.png",width:40,height:40) : const Text(""),
                    ),
                  );
                },
              ),
            ),
          );
        },
      )
    );
  }
}
