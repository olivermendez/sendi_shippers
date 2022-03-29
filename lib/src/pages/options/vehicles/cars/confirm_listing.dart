import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_app/src/widgets/appbar/custom_appbar_category.dart';
import '../../../../../models/bodytypes.dart';
import '../../../../../models/listing/listing.dart';
import '../../../../../models/token.dart';
import '../../../../services/data_services.dart';

import 'package:http/http.dart' as http;

import 'locations.dart';
//TODO: Design better this page

class ConfirmVehicleListing extends StatelessWidget {
  final Token token;
  final Bodytype bodytypeSeleted;
  final String averageDimensions;
  final String averageWeight;
  final Listing listingCreated;

  const ConfirmVehicleListing({
    Key? key,
    required this.averageDimensions,
    required this.averageWeight,
    required this.listingCreated,
    required this.bodytypeSeleted,
    required this.token,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    const String date = "";
    return Scaffold(
      appBar: const CustomAppBarForCategory(
        categoryName: 'Confirmation Page',
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Your Shipment'),
            const Divider(),
            Text(listingCreated.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            const Text(
              "Description:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(listingCreated.description),
            const Divider(),
            const Text(
              "Your type of car:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                  child: InteractiveViewer(
                    minScale: 1.5,
                    maxScale: 2,
                    child: Container(
                        alignment: Alignment.center,
                        height: 150,
                        width: 150,
                        child: FadeInImage(
                          placeholder: const AssetImage('assets/loading.gif'),
                          image: AssetImage(
                              "assets/bodytypes/${bodytypeSeleted.image}"),
                        )),
                  ),
                ),
              ],
            ),
            const Divider(),
            Text('Total Weight: ' + averageWeight),
            const Divider(),
            Text('Total Dimensions: ' + averageDimensions),
            const Divider(),
            const Text(
              'Shipping Dates',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Divider(height: 10, color: Colors.white),
            const Text('Pick up Date Range'),
            Text(
                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
            const Divider(height: 10, color: Colors.white),
            const Text('Delivery Date Range'),
            Text(
                "${selectedDate.day + 3}/${selectedDate.month}/${selectedDate.year}"),
            const Divider(height: 30, color: Colors.white),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationCars(
                        listingCreated: listingCreated,
                        token: token,
                      ),
                    ),
                  );
                },
                child: const Text("Continue with the listing")),
          ],
        ),
      ),
    );
  }

  Future<void> CarDetail(
    String _bodytype,
    String _dimensions,
    String _weight,
    bool _operable,
    bool _convertible,
    bool _modified,
    Token token,
    BuildContext context,
  ) async {
    Map<String, dynamic> request = {
      "bodytype": _bodytype,
      "dimensions": _dimensions,
      "weight": _weight,
      "operable": _operable,
      "convertible": _convertible,
      "modified": _modified
    };

    var url =
        Uri.parse('${Constants.apiUrl}listings/${listingCreated.id}/vehicle');

    var response = await http.post(
      url,
      body: jsonEncode(request),
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer ${token.token}'
      },
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationCars(
          listingCreated: listingCreated,
          token: token,
        ),
      ),
    );

    /*

    var body = response.body;
    var decodedJson = jsonDecode(body);
    var listing = ListingResponse.fromJson(decodedJson);
    print(listing.listing.id);





    Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false,
        arguments: token);
     var body = response.body;
    var decodedJson = jsonDecode(body);
    var listing = ListingResponse.fromJson(decodedJson);
    print(listing.listing.id); 

    floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        label: const Text(
          "Create Shipment Now",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          CarDetail(bodytypeSeleted.value, averageDimensions, averageWeight,
              true, false, false, token, context);
        },
        backgroundColor: Colors.blue,
      ),

    */
  }
}
