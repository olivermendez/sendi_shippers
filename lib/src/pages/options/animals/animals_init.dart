import 'package:flutter/material.dart';
import 'package:my_app/domain/entities/models/commodities/commodities_models.dart';
import 'package:my_app/models/commodities.dart';
import 'package:my_app/models/token.dart';

import 'cats/cats.dart';
import 'dogs/dogs.dart';
import 'horses/horses.dart';

class AnimalInit extends StatefulWidget {
  final Token token;
  final CommodityDetails seleted;
  final String item;
  AnimalInit(
      {required this.seleted,
      required this.item,
      required this.token,
      Key? key})
      : super(key: key);

  @override
  _AnimalInitState createState() => _AnimalInitState();
}

class _AnimalInitState extends State<AnimalInit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: addDynamic(widget.item, widget.token, widget.seleted, widget.item),
    );
  }
}

addDynamic(String item, Token token, CommodityDetails comoditySeleted,
    String subCommoditySeleted) {
  if (item == 'Cats') {
    return CatPage(
      seleted: comoditySeleted,
      subCommoditySeleted: subCommoditySeleted,
      token: token,
    );
  } else if (item == 'Dogs') {
    return DogPage(
      seleted: comoditySeleted,
      subCommoditySeleted: subCommoditySeleted,
      token: token,
    );
  } else if (item == 'Horses') {
    return HorsesPage(
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
