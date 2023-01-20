import 'package:flutter/material.dart';
import 'package:taxinet_admin/admin/sendsms.dart';
import "package:get/get.dart";
import '../constants/app_colors.dart';
import '../controller/requestscontroller.dart';

class UnlockCar extends StatefulWidget {
  const UnlockCar({Key? key}) : super(key: key);

  @override
  State<UnlockCar> createState() => _UnlockCarState();
}

class _UnlockCarState extends State<UnlockCar> {
  final RequestController requestController = Get.find();
  // List driversTrackingNumbers = ["+233594095982", "+233594097253", "+233594163113", "+233594143106", "+233594140062", "+233594162360",
  //   "+233594173115", "+233594140058", "+233594072852","+233552870497","+233594140061"];
  var items;

  final SendSmsController sendSms = SendSmsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
      appBar: AppBar(
          backgroundColor:Colors.transparent,
          elevation:0,
        title: const Text("Unlock Car")
      ),
      body: GetBuilder<RequestController>(builder:(controller){
        return ListView.builder(
            itemCount: controller.allDrivers != null ? controller.allDrivers.length : 0,
            itemBuilder: (BuildContext context, int index){
              items = controller.allDrivers[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      onTap: (){
                        sendSms.sendMySms(requestController.allDrivers[index], "0244529353", "relay,1\%23#");
                        Get.snackbar("Success", "${requestController.driversTrackerSims[index]} is unlocked now.",
                            duration: const Duration(seconds: 5),
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: primaryColor,
                            colorText: defaultTextColor1);
                      },
                      title: Padding(
                        padding: const EdgeInsets.only(bottom:10.0,top:10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(items['get_driver_tracker_sim_number'],style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text(items['username'],style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      subtitle:  const Padding(
                        padding: EdgeInsets.only(bottom:8.0),
                        child: Text("Tap to unlock car."),
                      ),
                    )
                ),
              );
            }
        );
      })
    );
  }
}
