import 'package:flutter/material.dart';
import 'package:my_app/domain/entities/models/commodities/commodities_models.dart';
import 'package:my_app/models/commodities.dart';

import 'package:my_app/models/token.dart';
import 'package:my_app/src/pages/options/household/outdoor_equipments/outdoor_equipment.dart';
import 'package:my_app/src/pages/options/household/sporting_equipments/sporting_equipment.dart';

import 'apliances/aplicances.dart';
import 'arcade_equipment/arcarde_equipment.dart';
import 'furnitures/furnitures.dart';
import 'home_electronics/home_electronics.dart';
import 'pianos/pianos.dart';

class RouteHouseholdCategory extends StatelessWidget {
  final Token token;
  final CommodityDetails seleted;
  final String item;
  const RouteHouseholdCategory(
      {required this.seleted,
      required this.item,
      required this.token,
      Key? key,
      String? label})
      : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: addDynamic(item, token, seleted, item),
    );
  }
}

addDynamic(String item, Token token, CommodityDetails comoditySeleted,
    String subCommoditySeleted) {
  if (item == 'Furniture') {
    return FurnituresPage(
      token: token,
      seleted: comoditySeleted,
      subCommoditySeleted: subCommoditySeleted,
    );
  } else if (item == 'Home Electronics') {
    return HomeElectronicsPage(
      token: token,
      selected: comoditySeleted,
      subCommoditySeleted: subCommoditySeleted,
    );
  } else if (item == 'Appliances') {
    return AppliancesPage(
      token: token,
      seleted: comoditySeleted,
      subCommoditySeleted: subCommoditySeleted,
    );
  } else if (item == 'Outdoor Equipment') {
    return OutdoorEquipmentPage(
      token: token,
      seleted: comoditySeleted,
      subCommoditySeleted: subCommoditySeleted,
    );
  } else if (item == 'Sporting Equipment') {
    return SportingEquipmentPage(
      token: token,
      seleted: comoditySeleted,
      subCommoditySeleted: subCommoditySeleted,
    );
  } else if (item == 'Arcade Equipment') {
    return ArcadeEquipmentPage(
      token: token,
      seleted: comoditySeleted,
      subCommoditySeleted: subCommoditySeleted,
    );
  } else if (item == 'Pianos') {
    return PianosPage(
        token: token,
        seleted: comoditySeleted,
        subCommoditySeleted: subCommoditySeleted);
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
