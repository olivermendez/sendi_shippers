import 'package:flutter/material.dart';
import 'package:my_app/models/commodities.dart';

import 'package:my_app/models/token.dart';
import 'package:my_app/src/pages/options/household/outdoor_equipment.dart';
import 'package:my_app/src/pages/options/household/sporting_equipment.dart';

import 'aplicances.dart';
import 'arcarde_equipment.dart';
import 'furnitures.dart';
import 'home_electronics.dart';
import 'pianos/pianos.dart';

class HouseHoldGoodsPage extends StatelessWidget {
  final Token token;
  final Commodity seleted;
  final String item;
  const HouseHoldGoodsPage(
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
      appBar: AppBar(
        title: Text(
          "New Move: " + item,
          style: const TextStyle(fontSize: 17),
        ),
        backgroundColor: Colors.black87,
        centerTitle: false,
      ),
      body: addDynamic(item, token),
    );
  }
}

addDynamic(String item, Token token) {
  if (item == 'Furniture') {
    return FurnituresPage(
      token: token,
    );
  } else if (item == 'Home Electronics') {
    return HomeElectronicsPage(
      token: token,
    );
  } else if (item == 'Appliances') {
    return AppliancesPage(
      token: token,
    );
  } else if (item == 'Outdoor Equipment') {
    return OutdoorEquipmentPage(
      token: token,
    );
  } else if (item == 'Sporting Equipment') {
    return SportingEquipmentPage(
      token: token,
    );
  } else if (item == 'Arcade Equipment') {
    return ArcadeEquipmentPage(
      token: token,
    );
  } else if (item == 'Pianos') {
    return PianosPage(
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
