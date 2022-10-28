import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../constants/app_colors.dart';
import '../controller/requestscontroller.dart';

class Investors extends StatefulWidget {
  const Investors({Key? key}) : super(key: key);

  @override
  State<Investors> createState() => _InvestorsState();
}

class _InvestorsState extends State<Investors> {
  final RequestController controller = Get.find();
  var items;

  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor:Colors.transparent,
          elevation:0,
          title: const Text("Investors",),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon:const Icon(Icons.arrow_back,color:defaultTextColor2)
          ),
        ),
        body: ListView.builder(
          itemCount: controller.allInvestors != null ? controller.allInvestors.length : 0,
          itemBuilder: (BuildContext context, int index) {
            items = controller.allInvestors[index];
            return Card(
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                onTap: (){
                  // print(controller.allInvestors[index]['user']);
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
                                      title: const Text("Email",),
                                      subtitle: Text(items['get_investors_email'])
                                  ),
                                  const Divider(),
                                  // const SizedBox(height:5),
                                  ListTile(
                                      title: const Text("Phone Number",),
                                      subtitle: Text(items['get_investors_phone_number'])
                                  ),
                                  ListTile(
                                      title: const Text("Next of kin",),
                                      subtitle: Text(items['next_of_kin'])
                                  ),
                                  // const SizedBox(height:5),
                                  const Divider(),
                                  // const SizedBox(height:5),
                                  ListTile(
                                      title: const Text("Next of kin number",),
                                      subtitle: Text(items['next_of_kin_number'])
                                  ),
                                ],
                              )
                          )
                      ),
                    ),
                  );
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(items['investors_profile_pic']),
                ),
                title: Text(items['get_investors_full_name']),
                subtitle: Text(items['get_investor_username']),
              ),
            );
          },
        ),
      ),
    );
  }
}
