import 'package:animate_do/animate_do.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:taxinet_admin/admin/searchpayments.dart';
import '../constants/app_colors.dart';
import '../controller/paymentcontroller.dart';
import 'allpayments.dart';

class Payments extends StatefulWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  // final PaymentsController controller = Get.find();
  var items;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor:Colors.transparent,
          elevation:0,
          title: const Text("Payments Today",),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon:const Icon(Icons.arrow_back,color:defaultTextColor2)
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(()=> const SearchPayments());
                },
                icon:const Icon(Icons.search,color:defaultTextColor2)
            )
          ],
        ),
        body: GetBuilder<PaymentsController>(builder:(controller){
          return ListView.builder(
              itemCount: controller.paymentsToday != null ? controller.paymentsToday.length : 0,
              itemBuilder: (context,index){
                items = controller.paymentsToday[index];
                return SlideInUp(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
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
                  ),

                );
              }
          );
        }),
        floatingActionButton:FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: (){
            Get.to(()=> const AllPayments());
          },
          child: const Text("All")
        )
      ),
    );
  }
}