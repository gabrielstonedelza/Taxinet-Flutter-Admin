import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../constants/app_colors.dart';
import 'package:http/http.dart' as http;

class UpdateRequest extends StatefulWidget {
  final slug;
  final passenger;
  final ride;
  final title;
  final price;
  final charge;
  const UpdateRequest({Key? key,required this.slug,required this.passenger,required this.ride,required this.title,required this.price, required this.charge}) : super(key: key);

  @override
  State<UpdateRequest> createState() => _UpdateRequestState(slug:this.slug, passenger:this.passenger,ride:this.ride,title:this.title,price:this.price, charge:this.charge);
}

class _UpdateRequestState extends State<UpdateRequest> {
  final slug;
  final passenger;
  final ride;
  final title;
  final price;
  final charge;
  _UpdateRequestState({required this.slug,required this.passenger,required this.ride,required this.title,required this.price, required this.charge});
  final storage = GetStorage();
  var username = "";
  String uToken = "";
  late final TextEditingController _priceController = TextEditingController();
  late final TextEditingController _chargeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _chargeFocusNode = FocusNode();
  bool isPosting = false;
  String updateMessage = "";
  bool hasUpdated = false;

  void _startPosting()async{
    setState(() {
      isPosting = true;
    });
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      isPosting = false;
      Get.snackbar("Success", "Ride was updated",
          colorText: defaultTextColor1,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryColor,
          duration: const Duration(seconds: 5)
      );
      Navigator.pop(context);
    });
  }

  updateRide()async {
    final requestUrl = "https://taxinetghana.xyz/admin_update_requested_ride/$slug/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.put(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',
      // "Authorization": "Token $uToken"
    }, body: {
      "passenger": passenger,
      "price": _priceController.text,
      "charge": _chargeController.text,
      "status": 'Active'
    });
    if(response.statusCode == 200){
      setState(() {
        isPosting = false;
        _priceController.text = "";
        _chargeController.text = "";
        updateMessage = "Update was successful";
        hasUpdated = true;
      });
      Get.snackbar("Success", "Ride was updated",
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
  void initState(){
    super.initState();
    if (storage.read("userToken") != null) {
      uToken = storage.read("userToken");
    }
    if (storage.read("username") != null) {
      username = storage.read("username");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update $title's price", style: const TextStyle(color: defaultTextColor2,fontSize: 15)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back, color: defaultTextColor2)),
      ),
      body: ListView(
        children: [
          const SizedBox(height:10),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _priceController,
                      focusNode: _priceFocusNode,
                      decoration: InputDecoration(
                          labelText:
                          price,
                          labelStyle:
                          const TextStyle(
                              color:
                              muted),
                          focusColor:
                          muted,
                          fillColor:
                          muted,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color:
                                  muted,
                                  width:
                                  2),
                              borderRadius:
                              BorderRadius.circular(
                                  12)),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(12))),
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter price";
                        }
                        else{
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height:10),
                    TextFormField(
                      controller: _chargeController,
                      focusNode: _chargeFocusNode,
                      decoration: InputDecoration(
                          labelText:
                          charge,
                          labelStyle:
                          const TextStyle(
                              color:
                              muted),
                          focusColor:
                          muted,
                          fillColor:
                          muted,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color:
                                  muted,
                                  width:
                                  2),
                              borderRadius:
                              BorderRadius.circular(
                                  12)),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(12))),
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter charge";
                        }
                        else{
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height:10),
                    isPosting ? const Center(
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: 5,
                        backgroundColor: primaryColor,
                      ),
                    ) :
                    RawMaterialButton(
                      onPressed: () {
                        _startPosting();
                        setState(() {
                          isPosting = true;
                        });
                        if (!_formKey.currentState!.validate()) {
                          Get.snackbar("Error", "Something went wrong",
                              colorText: defaultTextColor1,
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red
                          );
                          return;
                        } else {
                          updateRide();
                        }
                      },
                      // child: const Text("Send"),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius
                              .circular(
                              8)),
                      elevation: 8,
                      fillColor:
                      primaryColor,
                      splashColor:
                      defaultColor,
                      child: const Text(
                        "Update",
                        style: TextStyle(
                            fontWeight:
                            FontWeight
                                .bold,
                            fontSize: 20,
                            color:
                            defaultTextColor1),
                      ),
                    ),
                    const SizedBox(height:10),
                    hasUpdated ? Text(updateMessage) : Container()
                  ],
                )),
          )
        ],
      ),
    );
  }
}
