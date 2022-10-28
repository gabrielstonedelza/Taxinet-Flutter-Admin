import "package:flutter/material.dart";

class Inventories extends StatefulWidget {
  const Inventories({Key? key}) : super(key: key);

  @override
  State<Inventories> createState() => _InventoriesState();
}

class _InventoriesState extends State<Inventories> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text("Inventories"),
        ),
      ),
    );
  }
}