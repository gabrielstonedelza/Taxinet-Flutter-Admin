import 'package:animate_do/animate_do.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";
import '../constants/app_colors.dart';
import '../controller/inventoriescontroller.dart';
import '../controller/paymentcontroller.dart';
import 'inventorydetail.dart';

class InventoriesDetail extends StatefulWidget {
  final inventory_date;
  const InventoriesDetail({Key? key,required this.inventory_date}) : super(key: key);

  @override
  State<InventoriesDetail> createState() => _InventoriesDetailState(inventory_date:this.inventory_date);
}

class _InventoriesDetailState extends State<InventoriesDetail> {
  final inventory_date;
  _InventoriesDetailState({required this.inventory_date});

  final InventoriesController controller = Get.find();
  var items;

  @override
  void initState(){
    super.initState();
    controller.getInventoriesByDate(inventory_date);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor:Colors.transparent,
          elevation:0,
          title: const Text("Inventories",),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon:const Icon(Icons.arrow_back,color:defaultTextColor2)
          ),
        ),
        body: ListView.builder(
            itemCount: controller.inventoriesDates != null ? controller.inventoriesDates.length : 0,
            itemBuilder: (context,index){
              items = controller.inventoriesDates[index];
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
                          Get.to(() => InventoryDetail(id:controller.inventoriesDates[index]['id'].toString()));
                        },
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(items['get_driver_profile_pic']),
                        ),
                        title: Text(items['get_drivers_name']),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top:8.0),
                          child: Text(items['date_checked']),
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
