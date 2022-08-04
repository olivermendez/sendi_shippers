import 'package:flutter/material.dart';
//import 'package:my_app/domain/entities/models/commodities/commodities_models.dart';
//import 'package:my_app/models/commodities.dart';

import 'package:my_app/models/token.dart';
import 'package:my_app/src/pages/options/household/route_category_household.dart';
import 'package:my_app/src/pages/options/vehicles/route_category_vehicle.dart';

import '../../../domain/entities/models/commodities/commodities_models.dart';
import '../../widgets/export_widgets.dart';
import '../options/animals/animals_init.dart';

class CommodityCategory extends StatefulWidget {
  final Token token;
  final CommodityDetails category;
  const CommodityCategory(
      {required this.category, required this.token, Key? key})
      : super(key: key);

  static const String routenName = 'detail';

  @override
  _CommodityCategoryState createState() => _CommodityCategoryState();
}
//TODO: Refactor with RoutePage

class _CommodityCategoryState extends State<CommodityCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBarForCategory(
          categoryName: widget.category.label,
        ),
        body: ListView.builder(
            itemCount: widget.category.subCommodities.length,
            itemBuilder: (context, index) {
              final opt = widget.category.subCommodities[index];
              return Card(
                elevation: 0,
                child: ListTile(
                  title: Text(opt.label),
                  leading: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 64,
                        minHeight: 64,
                        maxWidth: 64,
                        maxHeight: 64,
                      ),
                      child: FadeInImage(
                        placeholder: const AssetImage('assets/loading.gif'),
                        image: AssetImage("assets/sub/${opt.image}"),
                      )),
                  trailing: const Icon(Icons.arrow_right_alt),
                  onTap: () {
                    if (widget.category.label == "Vehicles") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RouteVehicleCategory(
                                    seleted: widget.category,
                                    item: opt.label,
                                    token: widget.token,
                                  )));
                    } else if (widget.category.label == "Household Items") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RouteHouseholdCategory(
                                    seleted: widget.category,
                                    item: opt.label,
                                    token: widget.token,
                                  )));
                    } else if (widget.category.label == "Animals") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnimalInit(
                                    seleted: widget.category,
                                    item: opt.label,
                                    token: widget.token,
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
                ),
              );
            }));
  }
}
