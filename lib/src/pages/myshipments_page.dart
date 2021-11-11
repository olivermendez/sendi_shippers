import 'package:flutter/material.dart';
import 'package:my_app/config/constant.dart';
import 'package:my_app/models/listing/dynamiclisting.dart';
import 'package:my_app/models/listing/listing.dart';
import 'package:my_app/models/token.dart';
import 'package:my_app/widgets/shipper_drawer.dart';

import 'package:http/http.dart' as http;

class MyShipmentPage extends StatelessWidget {
  final Token token;

  const MyShipmentPage({required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Container(
            padding: const EdgeInsets.all(8.0),
            child: const Text('My Shipments')),
      ),
      body: noShipmentCreated(),
      drawer: ShipperDrawer(token: token),
    );
  }

  Widget noShipmentCreated() {
    Future<DynamicListingResponse?> getListingByUser() async {
      var url = Uri.parse('${Constants.apiUrl}listings/user/${token.user.id}');

      var response = await http.get(
        url,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
      );
      final listingByUser = DynamicListingResponse.fromRawJson(response.body);
      return listingByUser;
    }

    return FutureBuilder(
      future: getListingByUser(),
      builder: (context, AsyncSnapshot<DynamicListingResponse?> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return DisplayOptions(snapshot.data!.listing);
        }
      },
    );
  }
}

class DisplayOptions extends StatelessWidget {
  final List<Listing> listing;
  const DisplayOptions(this.listing);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listing.length,
        itemBuilder: (context, index) {
          final opt = listing[index];

          return Card(
            elevation: 1,
            child: ListTile(
                title: Text(opt.title),
                subtitle: Text(opt.comodity),
                trailing: Text(opt.status),
                leading: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 64,
                      minHeight: 64,
                      maxWidth: 64,
                      maxHeight: 64,
                    ),
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/loading.gif'),
                      image: NetworkImage(opt.photo),
                    )),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ShipmentInformation(listing: opt)));
                }),
          );
        });
  }
}

class ShipmentInformation extends StatelessWidget {
  final Listing listing;
  const ShipmentInformation({Key? key, required this.listing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(listing.title)),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Comodity: " + listing.comodity),
              Text("Subcomodity: " + listing.subcomodity),
              Text("Description: " + listing.description),
              Text("Quantity " + listing.quantity),
              Text("Status: " + listing.status),
            ],
          ),
        ),
      ),
    );
  }
}
