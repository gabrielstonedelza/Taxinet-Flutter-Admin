import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:taxinet_admin/admin/updatevehicle.dart';
import '../../../constants/app_colors.dart';
import '../controller/notificationcontroller.dart';
import '../controller/usercontroller.dart';
import '../controller/vehiclecontroller.dart';
import '../shimmers/shimmerwidget.dart';
import 'addnewvehicle.dart';



class Vehicles extends StatefulWidget {

  const Vehicles({Key? key}) : super(key: key);

  @override
  State<Vehicles> createState() => _VehiclesState();
}

class _VehiclesState extends State<Vehicles> {
  UserController userController = Get.find();

  final VehiclesController controller = Get.find();
  final storage = GetStorage();
  late String username = "";
  late String uToken = "";
  late Timer _timer;
  var items;

  @override
  void initState() {
    super.initState();
    controller.getAllVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Vehicles (${controller.vehicles.length})"),
        ),
        backgroundColor: primaryColor,
        body: GetBuilder<VehiclesController>(builder:(controller){
          return ListView.builder(
              itemCount: controller.vehicles != null ? controller.vehicles.length :0,
              itemBuilder: (context,index){
                items = controller.vehicles[index];
                return Column(
                  children: [
                    const SizedBox(height: 2,),
                    SlideInUp(
                        animate: true,
                        child: Card(
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(onTap: (){
                              showMaterialModalBottomSheet(
                                context: context,
                                // expand: true,
                                isDismissible: true,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25.0))),
                                bounce: true,
                                builder: (context) => Padding(
                                  padding: EdgeInsets.only(
                                      bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                                  child: SizedBox(
                                      height: 600,
                                      child: ListView(
                                        // mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Get.to(() => UpdateVehicle(
                                                id:controller.vehicles[index]['id'].toString(),
                                                status:controller.vehicles[index]['status'],brand:controller.vehicles[index]['brand'],color:controller.vehicles[index]['color'],year:controller.vehicles[index]['year'],license_plate_number:controller.vehicles[index]['license_plate_number'],vin:controller.vehicles[index]['vin'],body_number:controller.vehicles[index]['body_number'],registration_certificate_number:controller.vehicles[index]['registration_certificate_number'],taxi_license_number:controller.vehicles[index]['taxi_license_number'],transmission:controller.vehicles[index]['transmission'],vboosters:controller.vehicles[index]['boosters'],child_safety_seats:controller.vehicles[index]['child_safety_seats'],code_name:controller.vehicles[index]['code_name'],category:controller.vehicles[index]['category'],model:controller.vehicles[index]['model'],));
                                            },
                                            child: const Text("Update")
                                          ),
                                          const SizedBox (height:10),
                                          Table(
                                            border: TableBorder.all(),
                                            columnWidths:const {
                                              0: FractionColumnWidth(0.5),
                                              1: FractionColumnWidth(0.25),
                                            },
                                            children: [
                                              buildRow(['Status',controller.vehicles[index]['status']],),
                                              buildRow(['Brand',controller.vehicles[index]['brand']],),
                                              buildRow(['Model',controller.vehicles[index]['model']],),
                                              buildRow(['Color',controller.vehicles[index]['color']],),
                                              buildRow(['Year',controller.vehicles[index]['year']],),
                                              buildRow(['Licence Plate No',controller.vehicles[index]['license_plate_number']],),
                                              buildRow(['Vin',controller.vehicles[index]['vin']],),
                                              buildRow(['Body No',controller.vehicles[index]['body_number']],),
                                              buildRow(['Registration Cert No',controller.vehicles[index]['registration_certificate_number']],),
                                              buildRow(['Taxi License No',controller.vehicles[index]['taxi_license_number']],),
                                              buildRow(['Transmission',controller.vehicles[index]['transmission']],),
                                              buildRow(['Boosters',controller.vehicles[index]['boosters']],),
                                              buildRow(['Child Safety Seats',controller.vehicles[index]['child_safety_seats']],),
                                              buildRow(['Code Name',controller.vehicles[index]['code_name']],),
                                              buildRow(['Category',controller.vehicles[index]['category']],),
                                              buildRow(['Date Registered',controller.vehicles[index]['date_registered'].toString().split('T').first],),
                                            ],
                                          ),
                                        ],
                                      )),
                                ),
                              );
                            },
                              leading: Image.asset("assets/images/taxinet_cab.png",width:40,height:40),
                              title: Center(child: Text(items['brand'])),
                              subtitle: Center(child: Text(items['model'])),
                            )
                        )
                    )
                  ],
                );
              }
          );
        }),
      floatingActionButton:FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Get.to(()=> const AddNewVehicle());
        },
        child: const Icon(Icons.add)
      )
    );
  }
  TableRow buildRow(List<String> cells,{bool isHeader=false})=>TableRow(
      children: cells.map((cell){
        final style = TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            fontSize: 18
        );
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(child: Text(cell,style: style,)),
        );
      }).toList()
  );
}

