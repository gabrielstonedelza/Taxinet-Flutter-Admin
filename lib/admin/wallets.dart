import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:get/get.dart";
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:taxinet_admin/admin/searchwallet.dart';
import '../constants/app_colors.dart';
import '../controller/walletcontroller.dart';
import 'package:http/http.dart' as http;

class AllWallets extends StatefulWidget {
  const AllWallets({Key? key}) : super(key: key);

  @override
  State<AllWallets> createState() => _AllWalletsState();
}

class _AllWalletsState extends State<AllWallets> {
  final WalletController controller = Get.find();
  var items;
  late final  TextEditingController newAmountController = TextEditingController();
  final FocusNode newAmountFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool isPosting = false;

  void _startPosting()async{
    setState(() {
      isPosting = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isPosting = false;
      newAmountController.text = "";
      Get.snackbar("Success", "Wallet was updated",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryColor,
          duration: const Duration(seconds: 5)
      );
      Navigator.pop(context);
    });
  }

  updateWallet(String id,String amount,String user)async {
    final requestUrl = "https://taxinetghana.xyz/admin_update_wallet/$id/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.put(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      // "Authorization": "Token $uToken"
    }, body: {
      "amount" : amount,
      "user" : user
    });
    if(response.statusCode == 200){
      setState(() {
        newAmountController.text = "";
      });

      Get.snackbar("Success", "wallet was updated",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryColor,
          duration: const Duration(seconds: 5)
      );
    }
    else{
      if (kDebugMode) {
        // print(response.body);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor:Colors.transparent,
          elevation:0,
          title: const Text("Wallets",),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon:const Icon(Icons.arrow_back,color:defaultTextColor2)
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(()=> const SearchWallet());
                },
                icon:const Icon(Icons.search,color:defaultTextColor2)
            )
          ],
        ),
        body: GetBuilder<WalletController>(builder:(controller){
          return ListView.builder(
            itemCount: controller.allWallets != null ? controller.allWallets.length : 0,
            itemBuilder: (BuildContext context, int index) {
              items = controller.allWallets[index];
              return Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: items['get_profile_pic'] != null ? CircleAvatar(
                    backgroundImage: NetworkImage(items['get_profile_pic']),
                  ) : const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/user.png"),
                    radius: 20,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom:10.0,top:10),
                    child: Text(items['get_full_name']),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(items['get_username']),
                      const SizedBox(height:10),
                      Text(items['get_user_type']),
                      const SizedBox(height:10),
                    ],
                  ),
                  trailing: Text("₵${items['amount']}",style: const TextStyle(fontWeight: FontWeight.bold)),
                  // trailing: CachedNetworkImage(
                  //   imageUrl: items['driver_profile_pic'],
                  //   placeholder: (context, url) => const CircularProgressIndicator(),
                  //   errorWidget: (context, url, error) => const Icon(Icons.error),
                  // ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
