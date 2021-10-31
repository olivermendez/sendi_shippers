import 'package:flutter/material.dart';
import 'package:my_app/models/commodities.dart';

class VehiclePageForm extends StatefulWidget {
  final Commodity seleted;
  final String item;
  const VehiclePageForm(
      {required this.seleted, required this.item, Key? key, String? label})
      : super(key: key);

  static String routeName = 'vehicles';

  @override
  State<VehiclePageForm> createState() => _VehiclePageFormState();
}

class _VehiclePageFormState extends State<VehiclePageForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Moving: " + widget.item,
          style: TextStyle(fontSize: 17),
        ),
        backgroundColor: Colors.black87,
        centerTitle: false,
      ),
    );
  }
}
