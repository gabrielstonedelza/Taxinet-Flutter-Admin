import 'package:animate_do/animate_do.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";
import '../constants/app_colors.dart';
import '../controller/inventoriescontroller.dart';
import 'inventoriesdetail.dart';

class AllInventories extends StatefulWidget {
  const AllInventories({Key? key}) : super(key: key);

  @override
  State<AllInventories> createState() => _AllInventoriesState();
}

class _AllInventoriesState extends State<AllInventories> {
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
          title: const Text("All Inventories",),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon:const Icon(Icons.arrow_back,color:defaultTextColor2)
          ),
        ),
        body: ListView.builder(
            itemCount: controller.inventoryDates != null ? controller.inventoryDates.length : 0,
            itemBuilder: (context,index){
              items = controller.inventoryDates[index];
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
                          Get.to(() => InventoriesDetail(inventory_date:controller.inventoryDates[index]));
                        },
                        title: Text(items),
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