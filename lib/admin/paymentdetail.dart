import 'package:animate_do/animate_do.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";
import '../constants/app_colors.dart';
import '../controller/paymentcontroller.dart';

class PaymentDetail extends StatefulWidget {
  final payment_date;
  const PaymentDetail({Key? key,required this.payment_date}) : super(key: key);

  @override
  State<PaymentDetail> createState() => _PaymentDetailState(payment_date:this.payment_date);
}

class _PaymentDetailState extends State<PaymentDetail> {
  final payment_date;
  _PaymentDetailState({required this.payment_date});

  final PaymentsController controller = Get.find();
  var items;

  @override
  void initState(){
    super.initState();
    controller.getPaymentsByDate(payment_date);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            backgroundColor:Colors.transparent,
            elevation:0,
            title: const Text("Payments",),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon:const Icon(Icons.arrow_back,color:defaultTextColor2)
            ),
          ),
          body: ListView.builder(
              itemCount: controller.datesPaid != null ? controller.datesPaid.length : 0,
              itemBuilder: (context,index){
                items = controller.datesPaid[index];
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
          ),

      ),
    );
  }
}
