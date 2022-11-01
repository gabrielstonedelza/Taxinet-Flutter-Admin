import 'dart:convert';
import "package:get/get.dart";
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

import '../constants/app_colors.dart';

class InventoryDetail extends StatefulWidget {
  final id;
  const InventoryDetail({Key? key,required this.id}) : super(key: key);

  @override
  State<InventoryDetail> createState() => _InventoryDetailState(id:this.id);
}

class _InventoryDetailState extends State<InventoryDetail> {
  final id;
  _InventoryDetailState({required this.id});
  String driversPic = "";
  String driversName = "";
  String registrationNumber= "";
  String uniqueNumber= "";
  String vehicleBrand= "";
  String millage= "";
  String windscreen= "";
  String sideMirror= "";
  String registrationPlate= "";
  String tirePressure= "";
  String drivingMirror= "";
  String tireThreadDepth= "";
  String wheelNuts= "";
  String engineOil= "";
  String fuelLevel= "";
  String breakFluid= "";
  String radiatorEngineCoolant= "";
  String powerSteeringFluid= "";
  String wiperWasherFluid= "";
  String seatBelts= "";
  String steeringWheel= "";
  String horn= "";
  String electricWindows= "";
  String windscreenWipers= "";
  String headLights= "";
  String trafficators= "";
  String tailRearLights= "";
  String reverseLights= "";
  String interiorLights= "";
  String engineNoise= "";
  String excessiveSmoke= "";
  String footBreak= "";
  String handBreak= "";
  String wheelBearingNoise= "";
  String warningTriangle= "";
  String fireExtinguisher= "";
  String firstAidBox= "";
  late bool checkedToday;
  String dateChecked= "";
  String timeChecked= "";

  bool isLoading = true;

  Future<void> getDetailInventory() async {
    final walletUrl = "https://taxinetghana.xyz/admin_get_driver_inventory_detail/$id/";
    var link = Uri.parse(walletUrl);
    http.Response response = await http.get(link, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    });
    if (response.statusCode == 200) {
      final codeUnits = response.body;
      var jsonData = jsonDecode(codeUnits);
      driversPic = jsonData['get_driver_profile_pic'];
      driversName = jsonData['get_drivers_name'];
      registrationNumber = jsonData['registration_number'];
      uniqueNumber = jsonData['unique_number'];
      vehicleBrand = jsonData['vehicle_brand'];
      millage = jsonData['millage'];
      windscreen = jsonData['windscreen'];
      sideMirror = jsonData['side_mirror'];
      registrationPlate = jsonData['registration_plate'];
      tirePressure = jsonData['tire_pressure'];
      drivingMirror = jsonData['driving_mirror'];
      tireThreadDepth = jsonData['tire_thread_depth'];
      wheelNuts = jsonData['wheel_nuts'];
      engineOil = jsonData['engine_oil'];
      fuelLevel = jsonData['fuel_level'];
      breakFluid = jsonData['break_fluid'];
      radiatorEngineCoolant = jsonData['radiator_engine_coolant'];
      powerSteeringFluid = jsonData['power_steering_fluid'];
      wiperWasherFluid = jsonData['wiper_washer_fluid'];
      seatBelts = jsonData['seat_belts'];
      steeringWheel = jsonData['steering_wheel'];
      horn = jsonData['horn'];
      electricWindows = jsonData['electric_windows'];
      windscreenWipers = jsonData['windscreen_wipers'];
      headLights = jsonData['head_lights'];
      trafficators = jsonData['trafficators'];
      tailRearLights = jsonData['tail_rear_lights'];
      reverseLights = jsonData['reverse_lights'];
      interiorLights = jsonData['interior_lights'];
      engineNoise = jsonData['engine_noise'];
      excessiveSmoke = jsonData['excessive_smoke'];
      footBreak = jsonData['foot_break'];
      handBreak = jsonData['hand_break'];
      wheelBearingNoise = jsonData['wheel_bearing_noise'];
      warningTriangle = jsonData['warning_triangle'];
      fireExtinguisher = jsonData['fire_extinguisher'];
      firstAidBox = jsonData['first_aid_box'];
      checkedToday = jsonData['checked_today'];
      dateChecked = jsonData['date_checked'];
      timeChecked = jsonData['time_checked'];
    }
    else{
      if (kDebugMode) {
        print(response.body);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDetailInventory();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        backgroundColor: primaryColor,
          appBar: AppBar(
            backgroundColor:Colors.transparent,
            elevation:0,
            title: Text("$driversName's Inventory",),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon:const Icon(Icons.arrow_back,color:defaultTextColor2)
            ),
          ),
        body: isLoading ? const Center(
            child:CircularProgressIndicator.adaptive(
              strokeWidth: 5,
              backgroundColor: primaryColor,
            )
        ) :ListView(
          children: [
            const SizedBox(height: 10),
            Card(
              elevation: 12,
              child: Table(
                border: TableBorder.all(),
                columnWidths:const {
                  0: FractionColumnWidth(0.5),
                  1: FractionColumnWidth(0.25),
                },
                children: [
                  buildRow(['Device',"Condition"],isHeader:true),
                  buildRow(['Vehicle Brand',vehicleBrand]),
                  buildRow(['Registration Number',registrationNumber]),
                  buildRow(['Unique Number',uniqueNumber]),
                  buildRow(['Millage',millage]),
                  buildRow(['windscreen',windscreen]),
                  buildRow(['Side Mirror',sideMirror]),
                  buildRow(['Registration Plate',registrationPlate]),
                  buildRow(['Tyre Pressure',tirePressure]),
                  buildRow(['Driving Mirror',drivingMirror]),
                  buildRow(['Tyre Thread Depth',tireThreadDepth]),
                  buildRow(['Wheel Nuts',wheelNuts]),
                  buildRow(['Engine Oil',engineOil]),
                  buildRow(['Fuel Level',fuelLevel]),
                  buildRow(['Break Fluid',breakFluid]),
                  buildRow(['Radiator Engine Coolant',radiatorEngineCoolant]),
                  buildRow(['Power Steering Fluid',powerSteeringFluid]),
                  buildRow(['Wiper Washer Fluid',wiperWasherFluid]),
                  buildRow(['Seat Belts',seatBelts]),
                  buildRow(['Steering Wheel',steeringWheel]),
                  buildRow(['Horn',horn]),
                  buildRow(['Electric Windows',electricWindows]),
                  buildRow(['Windscreen Wiper',windscreenWipers]),
                  buildRow(['Head Lights',headLights]),
                  buildRow(['Trafficators',trafficators]),
                  buildRow(['Tail Rear Lights',tailRearLights]),
                  buildRow(['Reverse Lights',reverseLights]),
                  buildRow(['Interior Lights',interiorLights]),
                  buildRow(['Engine Noise',engineNoise]),
                  buildRow(['Excessive Smoke',excessiveSmoke]),
                  buildRow(['Foot Break',footBreak]),
                  buildRow(['Hank Break',handBreak]),
                  buildRow(['Wheel Bearing Noise',wheelBearingNoise]),
                  buildRow(['Warning Triangle',warningTriangle]),
                  buildRow(['Fire Extinguisher',fireExtinguisher]),
                  buildRow(['First Aid Box',firstAidBox]),
                  buildRow(['Checked Today',checkedToday.toString()]),
                  buildRow(['Date Checked',dateChecked]),
                  buildRow(['Time Checked',timeChecked.toString().split('.').first]),

                ],
              ),
            )
          ],
        )
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
