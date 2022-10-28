import 'package:animate_do/animate_do.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";
import '../constants/app_colors.dart';
import '../controller/paymentcontroller.dart';

class AllPayments extends StatefulWidget {
  const AllPayments({Key? key}) : super(key: key);

  @override
  State<AllPayments> createState() => _AllPaymentsState();
}

class _AllPaymentsState extends State<AllPayments> {
  final PaymentsController controller = Get.find();
  var items;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            backgroundColor:Colors.transparent,
            elevation:0,
            title: const Text("All Payments",),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon:const Icon(Icons.arrow_back,color:defaultTextColor2)
            ),
          ),
          body: ListView.builder(
              itemCount: controller.payments != null ? controller.payments.length : 0,
              itemBuilder: (context,index){
                items = controller.payments[index];
                return SlideInUp(
                  child: Card(
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(items['get_driver_profile_pic']),
                        ),
                        title: Text(items['get_drivers_full_name']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const SizedBox(height: 5),
                            Text("GHS ${items['amount']}"),
                            const SizedBox(height: 5),
                            Text(items['date_paid']),
                            const SizedBox(height: 5),
                            Text(items['time_paid'].toString().split(".").first),
                          ],
                        ),
                      )
                  ),

                );
              }
          ),

      ),
    );
  }
}