import 'package:flutter/material.dart';
import 'package:my_app/models/commodities.dart';

class MotorcyclesPageForm extends StatefulWidget {
  final Commodity seleted;
  final String item;
  const MotorcyclesPageForm(
      {required this.seleted, required this.item, Key? key, String? label})
      : super(key: key);

  static String routeName = 'vehicles';

  @override
  State<MotorcyclesPageForm> createState() => _MotorcyclesPageForm();
}

class _MotorcyclesPageForm extends State<MotorcyclesPageForm> {
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
