import 'package:flutter/material.dart';
import 'package:my_app/models/commodities.dart';
import 'package:my_app/models/response_options.dart';
import 'package:my_app/models/token.dart';
import 'package:my_app/src/pages/create/category_seleted.dart';

import '../../services/data_services.dart';
import '../../widgets/export_widgets.dart';

class CreateShipmentPage extends StatefulWidget {
  final Token token;
  const CreateShipmentPage({required this.token, Key? key}) : super(key: key);

  @override
  State<CreateShipmentPage> createState() => _CreateShipmentPageState();
}

class _CreateShipmentPageState extends State<CreateShipmentPage> {
  final _dataServices = DataServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: CustomScrollView(
        slivers: [
          CustomAppBarShipper(token: widget.token),
          MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: SliverFillRemaining(
              child: FutureBuilder(
                future: _dataServices.getListOfCommodities(),
                builder: (context, AsyncSnapshot<OptionsResponse?> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ShowListOfTypeOfCommodities(
                        snapshot.data!.options.commodities, widget.token);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShowListOfTypeOfCommodities extends StatelessWidget {
  final Token token;
  final List<Commodity> listOfCommodities;
  const ShowListOfTypeOfCommodities(this.listOfCommodities, this.token);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listOfCommodities.length,
        itemBuilder: (context, index) {
          final opt = listOfCommodities[index];

          return Card(
            elevation: 0,
            child: ListTile(
                title: Text(opt.label,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(opt.shortLabel),
                leading: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 74,
                      minHeight: 74,
                      maxWidth: 74,
                      maxHeight: 74,
                    ),
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/loading.gif'),
                      image: AssetImage("assets/${opt.route}"),
                    )),
                //subtitle: Text(opt.shortLabel),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommodityCategory(
                        category: listOfCommodities[index],
                        token: token,
                      ),
                    ),
                  );
                }),
          );
        });
  }
}
