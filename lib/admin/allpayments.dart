import 'package:animate_do/animate_do.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:taxinet_admin/admin/paymentdetail.dart';
import '../constants/app_colors.dart';
import '../controller/paymentcontroller.dart';

class AllPayments extends StatefulWidget {
  const AllPayments({Key? key}) : super(key: key);

  @override
  State<AllPayments> createState() => _AllPaymentsState();
}

class _AllPaymentsState extends State<AllPayments> {
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
            title: const Text("All Payments",),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon:const Icon(Icons.arrow_back,color:defaultTextColor2)
            ),
          ),
          body: GetBuilder<PaymentsController>(builder:(controller){
            return ListView.builder(
                itemCount: controller.paymentDates != null ? controller.paymentDates.length : 0,
                itemBuilder: (context,index){
                  items = controller.paymentDates[index];
                  return SlideInUp(
                    animate: true,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            onTap: (){
                              Get.to(() => PaymentDetail(payment_date:controller.paymentDates[index]));
                            },
                            title: Text(items),
                          )
                      ),
                    ),

                  );
                }
            );
          }),

      ),
    );
  }
}