import 'package:flutter/material.dart';
import 'package:my_app/models/commodities.dart';
import 'package:my_app/models/token.dart';
import 'atvs/atvs.dart';
import 'bodytypes.dart';
import 'motor/bodytypes.dart';
import 'parts/parts.dart';
import 'trailers/trailers.dart';

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
      body: addDynamic(widget.item, widget.token, widget.seleted, widget.item),
    );
  }
}

addDynamic(String item, Token token, Commodity comoditySeleted,
    String subCommoditySeleted) {
  if (item == 'Cars & Light Trucks') {
    return CarsAndLightTrucksPage(
      token: token,
    );
  } else if (item == 'Trailers') {
    return const TrailersPage();
  } else if (item == 'Vehicle Parts') {
    return VehiclePartsPage(
      seleted: comoditySeleted,
      subCommoditySeleted: subCommoditySeleted,
      token: token,
    );
  } else if (item == 'Motorcycles & Mopeds') {
    return MotorcyclesBodyTypes(
      token: token,
    );
  } else if (item == 'ATVS & Power Sports') {
    return ATVSPage(
      seleted: comoditySeleted,
      subCommoditySeleted: subCommoditySeleted,
      token: token,
    );
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
