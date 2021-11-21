import 'package:flutter/material.dart';
import 'package:my_app/models/commodities.dart';
import 'package:my_app/models/token.dart';
import 'package:my_app/src/pages/options/animals/initial_form.dart';

class CatPage extends StatelessWidget {
  final Commodity seleted;
  final String subCommoditySeleted;
  final Token token;

  const CatPage({
    required this.seleted,
    required this.subCommoditySeleted,
    required this.token,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(subCommoditySeleted),
      ),
      body: InitialFormAnimals(
        token: token,
        subCommoditySeleted: subCommoditySeleted,
      ),
    );
  }
}
