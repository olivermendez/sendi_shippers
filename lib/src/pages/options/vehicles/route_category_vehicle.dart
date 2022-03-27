import 'package:flutter/material.dart';
import 'package:my_app/models/commodities.dart';
import 'package:my_app/models/token.dart';
import 'package:my_app/src/pages/options/vehicles/power_boast/power_boast.dart';
import 'package:my_app/src/pages/options/vehicles/sail_boast/sail_boast.dart';
import 'package:my_app/src/pages/options/vehicles/trucks/commercial_trucks.dart';
import 'package:my_app/src/pages/options/vehicles/watercrafts/watercrafts.dart';
import 'atvs/atvs.dart';
import 'cars/select_bodytype.dart';
import 'motor/motorbodytypes.dart';
import 'parts/parts.dart';

class RouteVehicleCategory extends StatefulWidget {
  final Token token;
  final Commodity seleted;
  final String item;
  const RouteVehicleCategory(
      {required this.seleted,
      required this.item,
      required this.token,
      Key? key,
      String? label})
      : super(key: key);

  @override
  State<RouteVehicleCategory> createState() => _RouteVehicleCategoryState();
}

class _RouteVehicleCategoryState extends State<RouteVehicleCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: route(widget.item, widget.token, widget.seleted, widget.item),
    );
  }
}

route(String item, Token token, Commodity comoditySeleted,
    String subCommoditySeleted) {
  if (item == 'Cars & Light Trucks') {
    return CarsSelectBodyTypePage(
      token: token,
    );
  } else if (item == 'Vehicle Parts') {
    return VehiclePartsPage(
      seleted: comoditySeleted,
      subCommoditySeleted: subCommoditySeleted,
      token: token,
    );
  } else if (item == 'ATVS & Power Sports') {
    return ATVSPage(
      seleted: comoditySeleted,
      subCommoditySeleted: subCommoditySeleted,
      token: token,
    );
  } else if (item == 'Motorcycles & Mopeds') {
    return MotorcyclesBodyTypes(
      token: token,
    );
  } else if (item == 'Power Boast') {
    return PowerBoastPage(
      seleted: comoditySeleted,
      subCommoditySeleted: subCommoditySeleted,
      token: token,
    );
  } else if (item == 'SailBoast') {
    return SailBoastPage(
      seleted: comoditySeleted,
      subCommoditySeleted: subCommoditySeleted,
      token: token,
    );
  } else if (item == 'Personal Watercrafts') {
    return WaterCraftsPage(
      seleted: comoditySeleted,
      subCommoditySeleted: subCommoditySeleted,
      token: token,
    );
  } else if (item == 'Commercial Trucks') {
    return CommercialTrucksPage(
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
