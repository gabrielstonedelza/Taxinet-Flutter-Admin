import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:taxinet_admin/admin/searchdriver.dart';
import '../constants/app_colors.dart';
import '../controller/requestscontroller.dart';
import '../controller/userscontrollers.dart';

class AllDrivers extends StatefulWidget {
  const AllDrivers({Key? key}) : super(key: key);

  @override
  State<AllDrivers> createState() => _AllDriversState();
}

class _AllDriversState extends State<AllDrivers> {
  final UsersController userController = Get.find();
  final RequestController controller = Get.find();
  var items;

  @override
  void initState(){
    super.initState();
    // print(controller.allDrivers);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor:Colors.transparent,
          elevation:0,
          title: const Text("Drivers",),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon:const Icon(Icons.arrow_back,color:defaultTextColor2)
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(()=> const SearchDriver());
                },
                icon:const Icon(Icons.search,color:defaultTextColor2)
            )
          ],
        ),
        body: ListView.builder(
          itemCount: controller.allDrivers != null ? controller.allDrivers.length : 0,
          itemBuilder: (BuildContext context, int index) {
            items = controller.allDrivers[index];
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
                          height: 500,
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: ListView(
                              children: [
                                const SizedBox(height:10),
                                const Center(
                                  child: Text("Other Info",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
                                ),
                                ListTile(
                                  title: const Text("Name on license",),

                                  subtitle: Text(items['name_on_licence'])
                                ),
                                // const SizedBox(height:5),
                                const Divider(),
                                // const SizedBox(height:5),
                                ListTile(
                                    title: const Text("License Number",),
                                    subtitle: Text(items['license_number'])
                                ),
                                const Divider(),
                                // const SizedBox(height:5),
                                ListTile(
                                    title: const Text("License Expiration Date",),
                                    subtitle: Text(items['license_expiration_date'])
                                ),
                                const Divider(),
                                // const SizedBox(height:5),
                                ListTile(
                                    title: const Text("License Plate",),
                                    subtitle: Text(items['license_plate'])
                                ),
                                const Divider(),
                                // const SizedBox(height:5),
                                ListTile(
                                    title: const Text("Car Model",),
                                    subtitle: Text(items['car_model'])
                                ),
                                const Divider(),
                                // const SizedBox(height:5),
                                ListTile(
                                    title: const Text("Car Name",),
                                    subtitle: Text(items['car_name'])
                                ),
                                ListTile(
                                    title: const Text("Unique Code",),
                                    subtitle: Text(items['unique_code'])
                                ),
                                ListTile(
                                    title: const Text("Taxinet Number",),
                                    subtitle: Text(items['taxinet_number'])
                                ),
                              ],
                            )
                          )
                      ),
                    ),
                  );
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(items['driver_profile_pic']),
                ),
                title: Text(items['get_drivers_full_name']),
                subtitle: Text(items['username']),
              ),
            );
          },
        ),
      ),
    );
  }
}
