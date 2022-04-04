import 'package:flutter/material.dart';
import 'package:my_app/models/commodities.dart';
import 'package:my_app/models/token.dart';

import '../initial_form.dart';

class DogPage extends StatelessWidget {
  final Commodity seleted;
  final String subCommoditySeleted;
  final Token token;
  const DogPage(
      {required this.seleted,
      required this.subCommoditySeleted,
      required this.token,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subCommoditySeleted),
      ),
      body: AnimalsForm(
        token: token,
        subCommoditySeleted: subCommoditySeleted,
      ),
    );
  }
}
