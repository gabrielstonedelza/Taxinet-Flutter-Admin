import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:get/get.dart";
import 'package:http/http.dart' as http;
import '../constants/app_colors.dart';
import '../controller/usercontroller.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final UserController controller = Get.find();
  var items;
  late List users = [];
  bool isSearching = false;

  void updateList(String value)async {

  }

  searchUsers(String searchItem)async{
    final url = "https://taxinetghana.xyz/search_users?search=$searchItem";
    var myLink = Uri.parse(url);
    final response = await http.get(myLink);

    if(response.statusCode ==200){
      final codeUnits = response.body.codeUnits;
      var jsonData = const Utf8Decoder().convert(codeUnits);
      users = json.decode(jsonData);
    }
    else{

    }

    setState(() {
      // isSearching = false;
      users = users;
    });
  }

  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor:Colors.transparent,
        elevation:0,
        title: const Text("Search Users",),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon:const Icon(Icons.arrow_back,color:defaultTextColor2)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value){
                if(value.isNotEmpty){
                  setState(() {
                    isSearching = true;
                  });
                  searchUsers(value);
                }
                if(value.isEmpty){
                  setState(() {
                    isSearching = false;
                  });
                }

              },
              style: const TextStyle(color:defaultTextColor1),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                filled: true,
                fillColor: defaultColor,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:BorderSide.none,

                ),
                hintText:  "eg: username, phone number,full name",
                prefixIcon: const Icon(Icons.search,color:Colors.white),
                prefixIconColor: Colors.white,
              ),
            ),
            const SizedBox (height:20),
            Expanded(
              child: isSearching ? users.length == 0 ? const Text("No results found",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: defaultTextColor1),): ListView.builder(
                  itemCount: users != null ? users.length : 0,
                  itemBuilder: (context,index){
                    items = users[index];
                    return SlideInUp(
                      animate: true,
                      child: Card(
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom:10.0, left:7),
                                child: Row(
                                  children: [
                                    const Text("Username: "),
                                    Text(items['username']),
                                  ],
                                ),
                              ),
                              subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom:8.0),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.person),
                                          Text(items['full_name']),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom:8.0),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.phone_android),
                                          Text(items['phone_number']),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom:8.0),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.person),
                                          Text(items['user_type']),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(FontAwesomeIcons.envelope),
                                        const SizedBox(width: 3,),
                                        Text(items['email']),
                                      ],
                                    ),
                                  ]
                              )
                          )
                      ),
                    );
                  }
              ) : Container()
            )
          ],
        ),
      )
    );
  }
}
