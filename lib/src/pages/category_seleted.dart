import 'package:flutter/material.dart';
import 'package:my_app/models/commodities.dart';
import 'package:my_app/models/token.dart';
import 'package:my_app/src/pages/options/boast/boast_page.dart';
import 'package:my_app/src/pages/options/household/household_init.dart';
import 'package:my_app/src/pages/options/motorcycles/motorcycles_page.dart';
import 'package:my_app/src/pages/options/vehicles/vehicles_init.dart';

class SubCommoditiePage extends StatefulWidget {
  final Token token;
  final Commodity seleted;
  const SubCommoditiePage(
      {required this.seleted, required this.token, Key? key})
      : super(key: key);

  static const String routenName = 'detail';

  @override
  _SubCommoditiePageState createState() => _SubCommoditiePageState();
}

class _SubCommoditiePageState extends State<SubCommoditiePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.seleted.label),
          backgroundColor: Colors.black87,
        ),
        body: ListView.builder(
            itemCount: widget.seleted.subCommodities.length,
            itemBuilder: (context, index) {
              final opt = widget.seleted.subCommodities[index];
              return ListTile(
                title: Text(opt.label),
                onTap: () {
                  if (widget.seleted.label == "Vehicles") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VehiclePageForm(
                                  seleted: widget.seleted,
                                  item: opt.label,
                                  token: widget.token,
                                )));
                  } else if (widget.seleted.label == "Household Items") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HouseHoldGoodsPage(
                                  seleted: widget.seleted,
                                  item: opt.label,
                                  token: widget.token,
                                )));
                  } else if (widget.seleted.label ==
                      "Motorcycles & Power Sports") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MotorcyclesPageForm(
                                  seleted: widget.seleted,
                                  item: opt.label,
                                )));
                  } else if (widget.seleted.label == "Boats") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BoastPageForm(
                                  seleted: widget.seleted,
                                  item: opt.label,
                                )));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Scaffold(
                                  appBar: AppBar(
                                    backgroundColor: Colors.red,
                                    title: const Text("Listing no found"),
                                  ),
                                )));
                  }
                },
              );
            }));
  }
}
