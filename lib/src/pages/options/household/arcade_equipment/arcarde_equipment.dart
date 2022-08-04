import 'package:flutter/material.dart';
import 'package:my_app/domain/entities/models/commodities/commodities_models.dart';
import 'package:my_app/models/commodities.dart';
import 'package:my_app/models/token.dart';

import '../moving_household.dart';

class ArcadeEquipmentPage extends StatelessWidget {
  final CommodityDetails seleted;
  final String subCommoditySeleted;
  final Token token;
  const ArcadeEquipmentPage(
      {required this.token,
      required this.seleted,
      required this.subCommoditySeleted,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(subCommoditySeleted)),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: InitialForm(
              token: token,
              seleted: seleted,
              subCommoditySeleted: subCommoditySeleted,
            ),
          ),
        ),
      ),
    );
  }
}
