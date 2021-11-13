import 'package:flutter/material.dart';
import 'package:my_app/models/commodities.dart';
import 'package:my_app/models/token.dart';
import 'airplanes.dart';
import 'bodytypes.dart';
import 'parts.dart';
import 'trailers.dart';

class VehiclePageForm extends StatefulWidget {
  final Token token;
  final Commodity seleted;
  final String item;
  const VehiclePageForm(
      {required this.seleted,
      required this.item,
      required this.token,
      Key? key,
      String? label})
      : super(key: key);

  @override
  State<VehiclePageForm> createState() => _VehiclePageFormState();
}

class _VehiclePageFormState extends State<VehiclePageForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: addDynamic(widget.item, widget.token),
    );
  }
}

addDynamic(String item, Token token) {
  if (item == 'Cars & Light Trucks') {
    return CarsAndLightTrucksPage(
      token: token,
    );
  } else if (item == 'Trailers') {
    return const TrailersPage();
  } else if (item == 'Vehicle Parts') {
    return const VehiclePartsPage();
  } else if (item == 'Airplanes') {
    return const AirplanesPage();
  } else {
    return Container(
      color: Colors.red,
      child: const Center(
        child: Text(
          "Listing no defined",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
