import 'package:flutter/material.dart';
import 'package:my_app/models/commodities.dart';
import 'package:my_app/models/token.dart';

class PowerBoastPage extends StatelessWidget {
  final Commodity seleted;
  final String subCommoditySeleted;
  final Token token;
  const PowerBoastPage(
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
          child: Text('Power Boast'),
        ));
  }
}
