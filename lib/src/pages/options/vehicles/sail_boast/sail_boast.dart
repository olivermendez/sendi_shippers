import 'package:flutter/material.dart';
import 'package:my_app/domain/entities/models/commodities/commodities_models.dart';
import 'package:my_app/models/commodities.dart';
import 'package:my_app/models/token.dart';

class SailBoastPage extends StatelessWidget {
  final CommodityDetails seleted;
  final String subCommoditySeleted;
  final Token token;
  const SailBoastPage(
      {Key? key,
      required this.seleted,
      required this.subCommoditySeleted,
      required this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(subCommoditySeleted),
        ),
        body: const Center(
          child: Text('Sail Boast'),
        ));
  }
}
