import 'package:flutter/material.dart';
import 'package:my_app/models/commodities.dart';
import 'package:my_app/models/token.dart';

import '../moving_household.dart';

class FurnituresPage extends StatelessWidget {
  final Commodity seleted;
  final String subCommoditySeleted;
  final Token token;
  const FurnituresPage(
      {required this.token,
      required this.seleted,
      required this.subCommoditySeleted,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(subCommoditySeleted)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: InitialForm(
            token: token,
            seleted: seleted,
            subCommoditySeleted: subCommoditySeleted,
          ),
        ),
      ),
    );
  }
}
