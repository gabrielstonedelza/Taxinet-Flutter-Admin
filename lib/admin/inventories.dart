import 'package:animate_do/animate_do.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";
import '../constants/app_colors.dart';
import '../controller/inventoriescontroller.dart';
import '../controller/paymentcontroller.dart';
import 'allinventories.dart';
import 'allpayments.dart';

class Inventories extends StatefulWidget {
  const Inventories({Key? key}) : super(key: key);

  @override
  State<Inventories> createState() => _InventoriesState();
}

class _InventoriesState extends State<Inventories> {
  final InventoriesController controller = Get.find();
  var items;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            backgroundColor:Colors.transparent,
            elevation:0,
            title: const Text("Inventories Today",),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon:const Icon(Icons.arrow_back,color:defaultTextColor2)
            ),
          ),
          body: ListView.builder(
              itemCount: controller.inventoriesToday != null ? controller.inventoriesToday.length : 0,
              itemBuilder: (context,index){
                items = controller.inventoriesToday[index];
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
                          title: Text(items['get_drivers_name']),
                          subtitle: Text(items['date_checked']),
                        )
                    ),
                  ),

                );
              }
          ),
          floatingActionButton:FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: (){
                Get.to(()=> const AllInventories());
              },
              child: const Text("All")
          )
      ),
    );
  }
}