import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_app/src/widgets/appbar/custom_appbar_category.dart';
import '../../../../../models/bodytypes.dart';
import '../../../../../models/listing/listing.dart';
import '../../../../../models/listing/response.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarForCategory(
        categoryName: 'Confirmation',
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: PageView(
                    children: <Widget>[
                      //Image.network(widget.listingCreated.photo),
                      Image.network(
                          "https://luxloungeefr.com/wp-content/uploads/2015/03/blue-custom.png"),
                      Image.network(
                          "https://luxloungeefr.com/wp-content/uploads/2015/03/blue-custom.png"),
                    ],
                  ),
                ),
              ),
              const Divider(),
              Text(
                listingCreated.title,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.normal),
              ),
              Text("Description: " + listingCreated.description),
              Text("Quantity: " + listingCreated.quantity),
              Text("Commodity: " + listingCreated.subcomodity),
              Row(children: [
                Expanded(
                  child: Container(
                    color: Colors.amber[30],
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Average Dimensions',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            averageDimensions,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const Text(
                            'Average Weight',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            averageWeight,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      height: 150,
                      width: 200,
                      child: FadeInImage(
                        placeholder: const AssetImage('assets/loading.gif'),
                        image: AssetImage(
                            "assets/bodytypes/${bodytypeSeleted.image}"),
                      )),
                ),
              ]),
            ],
          )),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                )));

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

    */
  }
}
