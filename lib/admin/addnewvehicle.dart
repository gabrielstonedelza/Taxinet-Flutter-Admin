import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:http/http.dart' as http;
import '../constants/app_colors.dart';


class AddNewVehicle extends StatefulWidget {
  const AddNewVehicle({Key? key}) : super(key: key);

  @override
  State<AddNewVehicle> createState() => _AddNewVehicleState();
}

class _AddNewVehicleState extends State<AddNewVehicle> {
  List toyotaBrands = [
    'Avalon',
    'BELTA',
    'CAMRY',
    'CENTURY',
    'ALLION',
    'LEVIN GT',
    'CROWN',
    'ETIOS',
    'MIRAI',
    'PRIUS',
    'AGYA',
    'AQUA',
    'COROLLA',
    'ETIOS',
    'GLANZA',
    'PASSO',
    'YARIS',
    '4RUNNER',
    'VENZA',
    'HIGHLANDER',
    'LAND CRUISER',
    'RAV4',
    'RUSH',
    'Vitz'
  ];
  List audiBrands = [
    'A1',
    'A3',
    'A4',
    'A5',
    'A6',
    'A7',
    'A8',
    'e-TRON GT',
    'TT COUPE/ROADSTER',
    'R8 COUPE/SPYDER',
    'Q2',
    'Q3',
    'Q3 SPORTBACK',
    'Q4 e-TRON',
    'Q4 SPORTBACK E-TRON',
    'Q5',
    'Q5 SPORTBACK',
    'Q6',
    'Q7',
    'Q8',
    'e-TRON'
  ];
  List bmwBrands = [
    '1 Series (F40)',
    '1 Series (F52)',
    '2 Series Gran Coupé',
    '2 Series',
    '3 Series',
    '4 Series',
    '5 Series',
    '6 Series',
    '7 Series',
    '8 Series',
    'X1',
    'X2',
    'X3',
    'X4',
    'X5',
    'X6',
    'X7',
    'Z4',
    '2 Series Active Tourer',
    'i3',
    'i4'
  ];
  List chevroletBrands = [
    'Bolt',
    'Cruze',
    'Menlo',
    'Onix',
    'Spark',
    'Cruze',
    'Malibu',
    'Monza',
    'Onix',
    'Optra',
    'Sail',
    'Camaro',
    'Corvette',
    'Colorado',
    'Montana',
    'S10',
    'Silverado',
    'Blazer',
    'Bolt EUV',
    'Captiva',
    'Equinox',
    'Groove'
  ];
  List fordBrands = [
    'FIESTA',
    'FOCUS',
    'ESCORT',
    'MONDEO',
    'TAURUS',
    'GT',
    'MUSTANG',
    'ECOSPORT',
    'EDGE',
    'EQUATOR',
    'ESCAPE'
  ];
  List fiatBrands = ['MOBI', 'NEW 500', 'PANDA', 'UNO', 'ARGO', 'CRONOS', 'TIPO', 'PULSE'];
  List hondaBrands = [
    'BRIO',
    'CITY HATCHBACK',
    'CIVIC HATCHBACK',
    'FIT',
    'ACCORD',
    'AMAZE',
    'CIVIC',
    'CRIDER',
    'ENVIX',
    'CR-V'
  ];
  List hyundaiBrands = [
    'ACCENT',
    'HB20',
    'i10',
    'i20',
    'i30',
    'ACCENT',
    'AURA',
    'CELESTA',
    'ELANTRA',
    'GRANDEUR',
    'IONIQ',
    'SONATA'
  ];
  List infinityBrands = ['Q50', 'Q60', 'QX50', 'QX55', 'QX60', 'QX80'];
  List jeepBrands = [
    'CHEROKEE',
    'COMPASS',
    'COMMANDER',
    'GRAND COMMANDER',
    'RENEGADE',
    'GLADIATOR'
  ];
  List kiaBrands = [
    'CEED',
    'FORTE5',
    'PICANTO',
    'RAY',
    'RIO',
    'FORTE',
    'K4',
    'K5',
    'K6',
    'K7',
    'K8',
    'K9',
    'STINGER',
    'PROCEED',
    'SOUL',
    'SONET',
    'SORENTO',
    'SPORTAGE'
  ];
  List lexusBrands = ['CT', 'IS', 'ES', 'LS', 'RC', 'LC', 'UX', 'NX', 'RX', 'RZ'];
  List mazdaBrands = [
    'MAZDA2',
    'MAZDA2 HYBRID',
    'MAZDA3',
    'MAZDA6',
    'CX-3',
    'CX-30',
    'CX-4',
    'CX-5',
    'CX-50',
    'CX-60'
  ];
  List mitsubishiBrands = ['Mitsubishi Adventure',
    'Mitsubishi Attrage',
    'Mitsubishi Carisma',
    'Mitsubishi Lettuce'];
  List nissanBrands = ['LEAF',
    'MICRA',
    'NOTE',
    'NOTE AURA',
    'TIIDA',
    'ALMERA',
    'ALTIMA',
    'FUGA',
    'LANNIA',
    'MAXIMA',
    'SENTRA',
    'SKYLINE',
    'ARIYA',
    'MURANO',
    'PATHFINDER',
    'PATROL',
    'ROGUE'];
  List opelBrands = ['ASTRA', 'CORSA', 'INSIGNIA', 'CROSSLAND', 'GRANDLAND', 'MOKKA'];
  List peugotBrands = ['208', '308', '301', '408', '508'];
  List renaultBrands = [
    'CLIO',
    'KWID',
    'MÉGANE',
    'SANDERO',
    'TWINGO	',
    'ZOE',
    'TALIANT',
    'ARKANA',
    'CAPTUR',
    'DUSTER',
    'KOLEOS'
  ];
  List suzukiBrands = [
    'ALTO',
    'BALENO',
    'CELERIO',
    'CULTUS',
    'IGNIS',
    'SWIFT',
    'WAGON R',
    'CIAZ',
    'DZIRE',
    'SWACE',
    'BREZZA'
  ];
  List vwBrands = [
    'GOL',
    'GOLF',
    'GRAN',
    'POLO',
    'ARTEON',
    'BORA',
    'LAMANDO',
    'LAVIDA',
    'MAGOTAN',
    'PASSAT',
    'PHIDEON',
    'VIRTUS'
  ];

  List vehicleStatus = [
    'Active',
    'Inactive',
    'Inspection',
    'In the shop',
    'Stolen',
    'In Garage',
  ];
  List vehicleBrands = [
    "Audi",
    "BMW",
    "Chevrolet",
    "Ford",
    "Fiat",
    "Honda",
    "Hyundai",
    "Infinity",
    "Jeep",
    "Kia",
    "Lexus",
    "Mazda",
    "Mitsubishi",
    "Nissan",
    "Opel",
    "Peugeot",
    "Renault",
    "Suzuki",
    "Toyota",
    "Volkswagen",
  ];
  List colorChoices = [
    "Yellow",
    "White",
    "Black",
    "Gray",
    "Red",
    "Dark Blue",
    "Light Blue",
    "Brown",
    "Green",
    "Pink",
    "Orange",
    "Purple",
    "Beige",
  ];
  List vehicleTransmissions = [
    "Mechanical",
    "Automatic",
    "Robotized",
    "Variator",
  ];
  List boosters = ["0","1","2","3"];
  List safetySeats = ["0","1","2","3"];
  List fleetCar = ["Unselected","Yes","No"];
  List vehicleCategory = ["Comfort","Courier","Economy","Delivery"];
  String currentSelectedStatus = "Inactive";
  String currentSelectedBrand = "Toyota";
  String currentSelectedColor = "White";
  String currentSelectedTransmission = "Mechanical";
  String currentSelectedBooster = "0";
  String currentSelectedChildSafety = "0";
  String currentSelectedFleetCar = "Unselected";
  String currentSelectedCategory = "Comfort";

  late final  TextEditingController modelController = TextEditingController();
  final FocusNode modelFocusNode = FocusNode();
  late final  TextEditingController yearController = TextEditingController();
  final FocusNode yearFocusNode = FocusNode();
  late final  TextEditingController licensePlateNumberController = TextEditingController();
  final FocusNode licensePlateNumberFocusNode = FocusNode();
  late final  TextEditingController vinController = TextEditingController();
  final FocusNode vinFocusNode = FocusNode();
  late final  TextEditingController bodyNumberController = TextEditingController();
  final FocusNode bodyNumberFocusNode = FocusNode();
  late final  TextEditingController regCertNumberController = TextEditingController();
  final FocusNode regCertNumberFocusNode = FocusNode();
  late final  TextEditingController taxiLicenseNumberController = TextEditingController();
  final FocusNode taxiLicenseNumberFocusNode = FocusNode();
  late final  TextEditingController codeNameController = TextEditingController();
  final FocusNode codeNameFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  late DateTime _dateTime;
  bool isPosting = false;

  void _startPosting()async{
    setState(() {
      isPosting = true;
    });
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      isPosting = false;
    });
  }

  registerVehicle() async {
    const requestUrl = "https://taxinetghana.xyz/admin_register_vehicle/";
    final myLink = Uri.parse(requestUrl);
    final response = await http.post(myLink, headers: {
      "Content-Type": "application/x-www-form-urlencoded",
      'Accept': 'application/json',

    }, body: {
      "status": currentSelectedStatus,
      "brand": currentSelectedBrand,
      "model": modelController.text,
      "color": currentSelectedColor,
      "year": yearController.text,
      "license_plate_number": licensePlateNumberController.text,
      "vin": vinController.text,
      "body_number": bodyNumberController.text,
      "registration_certificate_number": regCertNumberController.text,
      "taxi_license_number": taxiLicenseNumberController.text,
      "transmission": currentSelectedTransmission,
      "boosters": currentSelectedBooster,
      "child_safety_seats": currentSelectedChildSafety,
      "code_name": codeNameController.text,
      "category": currentSelectedCategory,
    });
    if (response.statusCode == 201) {
      Get.back();
      Get.snackbar("Success 😀", "vehicle created.",
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: primaryColor,
          colorText: defaultTextColor2);
      setState(() {
        currentSelectedStatus = "Inactive";
        currentSelectedBrand = "Toyota";
        currentSelectedColor = "White";
        currentSelectedTransmission = "Mechanical";
        currentSelectedBooster = "0";
        currentSelectedCategory = "Comfort";
        modelController.text = "";
        yearController.text = "";
        licensePlateNumberController.text = "";
        vinController.text = "";
        bodyNumberController.text = "";
        regCertNumberController.text = "";
        taxiLicenseNumberController.text = "";
        codeNameController.text = "";
      });
    }
    else{
      if (kDebugMode) {
        print(response.body);
      }
      Get.snackbar("Sorry 😢", "something went wrong,please try again later.",
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: defaultTextColor2);
    }
  }



  @override
  Widget build(BuildContext context) {
    Size size  = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text("Add new vehicle"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key:_formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Select Status",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: defaultTextColor2)),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: DropdownButton(
                          dropdownColor: Colors.black,
                          isExpanded: true,
                          underline: const SizedBox(),
                          style: const TextStyle(
                              color: defaultTextColor2, fontSize: 20),
                          items: vehicleStatus.map((dropDownStringItem) {
                            return DropdownMenuItem(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (newValueSelected) {
                            _onDropDownSelectedStatus(newValueSelected);
                          },
                          value: currentSelectedStatus,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text("Select Brand",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: defaultTextColor2)),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: DropdownButton(
                          dropdownColor: Colors.black,
                          isExpanded: true,
                          underline: const SizedBox(),
                          style: const TextStyle(
                              color: defaultTextColor2, fontSize: 20),
                          items: vehicleBrands.map((dropDownStringItem) {
                            return DropdownMenuItem(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (newValueSelected) {
                            _onDropDownSelectedBrand(newValueSelected);
                          },
                          value: currentSelectedBrand,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 10),
                        child: TextFormField(
                          controller: modelController,
                          focusNode: modelFocusNode,
                          autocorrect: true,
                          enableSuggestions: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter model",
                            hintStyle: TextStyle(color: defaultTextColor2,),
                          ),
                          cursorColor: defaultTextColor2,
                          style: const TextStyle(color: defaultTextColor2),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Enter model";
                            }
                            else{
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text("Select Color",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: defaultTextColor2)),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: DropdownButton(
                          dropdownColor: Colors.black,
                          isExpanded: true,
                          underline: const SizedBox(),
                          style: const TextStyle(
                              color: defaultTextColor2, fontSize: 20),
                          items: colorChoices.map((dropDownStringItem) {
                            return DropdownMenuItem(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (newValueSelected) {
                            _onDropDownSelectedColor(newValueSelected);
                          },
                          value: currentSelectedColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      controller: yearController,
                      cursorColor: primaryColor,
                      cursorRadius: const Radius.elliptical(10, 10),
                      cursorWidth: 10,
                      readOnly: true,
                      style: const TextStyle(color: defaultTextColor2),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.event,color: secondaryColor,),
                            onPressed: (){
                              showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2080)
                              ).then((value) {
                                setState(() {
                                  _dateTime = value!;
                                  yearController.text = _dateTime.toString().split("00").first;
                                });
                              });
                            },
                          ),
                          labelText: "click on icon to pick year",
                          labelStyle: const TextStyle(color: defaultTextColor2),
                          focusColor: primaryColor,
                          fillColor: primaryColor,
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: primaryColor, width: 2),
                              borderRadius: BorderRadius.circular(12)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please pick year";
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 10),
                        child: TextFormField(
                          controller: licensePlateNumberController,
                          focusNode: licensePlateNumberFocusNode,
                          autocorrect: true,
                          enableSuggestions: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter license plate number",
                            hintStyle: TextStyle(color: defaultTextColor2,),
                          ),
                          cursorColor: defaultTextColor2,
                          style: const TextStyle(color: defaultTextColor2),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Enter license plate number";
                            }
                            else{
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 10),
                        child: TextFormField(
                          controller: vinController,
                          focusNode: vinFocusNode,
                          autocorrect: true,
                          enableSuggestions: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter vin",
                            hintStyle: TextStyle(color: defaultTextColor2,),
                          ),
                          cursorColor: defaultTextColor2,
                          style: const TextStyle(color: defaultTextColor2),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Enter vin";
                            }
                            else{
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 10),
                        child: TextFormField(
                          controller: bodyNumberController,
                          focusNode: bodyNumberFocusNode,
                          autocorrect: true,
                          enableSuggestions: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter body number",
                            hintStyle: TextStyle(color: defaultTextColor2,),
                          ),
                          cursorColor: defaultTextColor2,
                          style: const TextStyle(color: defaultTextColor2),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Enter body number";
                            }
                            else{
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 10),
                        child: TextFormField(
                          controller: regCertNumberController,
                          focusNode: regCertNumberFocusNode,
                          autocorrect: true,
                          enableSuggestions: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter registration certificate number",
                            hintStyle: TextStyle(color: defaultTextColor2,),
                          ),
                          cursorColor: defaultTextColor2,
                          style: const TextStyle(color: defaultTextColor2),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Enter registration certificate number";
                            }
                            else{
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 10),
                        child: TextFormField(
                          controller: taxiLicenseNumberController,
                          focusNode: taxiLicenseNumberFocusNode,
                          autocorrect: true,
                          enableSuggestions: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter taxi license number",
                            hintStyle: TextStyle(color: defaultTextColor2,),
                          ),
                          cursorColor: defaultTextColor2,
                          style: const TextStyle(color: defaultTextColor2),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Enter taxi license number";
                            }
                            else{
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const Text("Select Transmission",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: defaultTextColor2)),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: DropdownButton(
                          dropdownColor: Colors.black,
                          isExpanded: true,
                          underline: const SizedBox(),
                          style: const TextStyle(
                              color: defaultTextColor2, fontSize: 20),
                          items: vehicleTransmissions.map((dropDownStringItem) {
                            return DropdownMenuItem(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (newValueSelected) {
                            _onDropDownSelectedTransmission(newValueSelected);
                          },
                          value: currentSelectedTransmission,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text("Select Boosters",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: defaultTextColor2)),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: DropdownButton(
                          dropdownColor: Colors.black,
                          isExpanded: true,
                          underline: const SizedBox(),
                          style: const TextStyle(
                              color: defaultTextColor2, fontSize: 20),
                          items: boosters.map((dropDownStringItem) {
                            return DropdownMenuItem(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (newValueSelected) {
                            _onDropDownSelectedBooster(newValueSelected);
                          },
                          value: currentSelectedBooster,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text("Select child safety seats",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: defaultTextColor2)),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: DropdownButton(
                          dropdownColor: Colors.black,
                          isExpanded: true,
                          underline: const SizedBox(),
                          style: const TextStyle(
                              color: defaultTextColor2, fontSize: 20),
                          items: safetySeats.map((dropDownStringItem) {
                            return DropdownMenuItem(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (newValueSelected) {
                            _onDropDownSelectedChildSafety(newValueSelected);
                          },
                          value: currentSelectedChildSafety,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0,right: 10),
                        child: TextFormField(
                          controller: codeNameController,
                          focusNode: codeNameFocusNode,
                          autocorrect: true,
                          enableSuggestions: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter code name",
                            hintStyle: TextStyle(color: defaultTextColor2,),
                          ),
                          cursorColor: defaultTextColor2,
                          style: const TextStyle(color: defaultTextColor2),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Enter code name";
                            }
                            else{
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text("Select category",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: defaultTextColor2)),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: DropdownButton(
                          dropdownColor: Colors.black,
                          isExpanded: true,
                          underline: const SizedBox(),
                          style: const TextStyle(
                              color: defaultTextColor2, fontSize: 20),
                          items: vehicleCategory.map((dropDownStringItem) {
                            return DropdownMenuItem(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem),
                            );
                          }).toList(),
                          onChanged: (newValueSelected) {
                            _onDropDownSelectedCategory(newValueSelected);
                          },
                          value: currentSelectedCategory,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height:20),
                  isPosting ? const Center(
                    child: CircularProgressIndicator.adaptive(strokeWidth:5,backgroundColor:primaryColor)
                  ) : Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black,
                    ),
                    height: size.height * 0.06,
                    width: size.width * 0.6,
                    child: RawMaterialButton(
                      onPressed: () {
                        _startPosting();
                        if (_formKey.currentState!.validate()) {
                          registerVehicle();
                        } else {
                          Get.snackbar("Error", "Something went wrong",
                              colorText: defaultTextColor2,
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.red
                          );
                          return;
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                      ),
                      elevation: 8,
                      fillColor: Colors.black,
                      splashColor: defaultColor,
                      child: const Text(
                        "Add",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: defaultTextColor1),
                      ),
                    ),
                  )
                ],
              )
            ),
          )
        ],
      ),
    );
  }

  void _onDropDownSelectedStatus(newValueSelected) {
    setState(() {
      currentSelectedStatus = newValueSelected;
    });
  }
  void _onDropDownSelectedBrand(newValueSelected) {
    setState(() {
      currentSelectedBrand = newValueSelected;
    });
  }
  void _onDropDownSelectedColor(newValueSelected) {
    setState(() {
      currentSelectedColor = newValueSelected;
    });
  }
  void _onDropDownSelectedTransmission(newValueSelected) {
    setState(() {
      currentSelectedTransmission = newValueSelected;
    });
  }
  void _onDropDownSelectedBooster(newValueSelected) {
    setState(() {
      currentSelectedBooster = newValueSelected;
    });
  }
  void _onDropDownSelectedChildSafety(newValueSelected) {
    setState(() {
      currentSelectedChildSafety = newValueSelected;
    });
  }
  void _onDropDownSelectedFleetCar(newValueSelected) {
    setState(() {
      currentSelectedFleetCar = newValueSelected;
    });
  }
  void _onDropDownSelectedCategory(newValueSelected) {
    setState(() {
      currentSelectedCategory = newValueSelected;
    });
  }
}
