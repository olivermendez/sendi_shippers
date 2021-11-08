import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/config/constant.dart';
import 'package:my_app/models/bodytypes.dart';
import 'package:my_app/models/commodities.dart';

import 'package:http/http.dart' as http;
import 'package:my_app/models/token.dart';
import 'package:my_app/src/pages/listing_locations.dart';

class VehiclePageForm extends StatefulWidget {
  final Token token;
  final Commodity seleted;
  final String item;
  const VehiclePageForm(
      {required this.seleted,
      required this.item,
      required this.token,
      Key? key,
      String? label})
      : super(key: key);

  static String routeName = 'vehicles';

  @override
  State<VehiclePageForm> createState() => _VehiclePageFormState();
}

class _VehiclePageFormState extends State<VehiclePageForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Moving: " + widget.item,
          style: TextStyle(fontSize: 17),
        ),
        backgroundColor: Colors.black87,
        centerTitle: false,
      ),
      body: addDynamic(widget.item, widget.token),
    );
  }
}

addDynamic(String item, Token token) {
  if (item == 'Cars & Light Trucks') {
    return CarsAndLightTrucksPage(
      token: token,
    );
  } else if (item == 'Trailers') {
    return const TrailersPage();
  } else if (item == 'Vehicle Parts') {
    return const VehiclePartsPage();
  } else if (item == 'Airplanes') {
    return const AirplanesPage();
  } else {
    return Container(
      color: Colors.red,
      child: const Center(
        child: Text(
          "Listing no defined",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}

class CarsAndLightTrucksPage extends StatelessWidget {
  final Token token;
  const CarsAndLightTrucksPage({required this.token, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: NewMoveVehicles(
          token: token,
        ),
      ),
    );
  }
}

class NewMoveVehicles extends StatefulWidget {
  final Token token;
  const NewMoveVehicles({required this.token, Key? key}) : super(key: key);

  @override
  State<NewMoveVehicles> createState() => _NewMoveVehicles();
}

class _NewMoveVehicles extends State<NewMoveVehicles> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String bodytype = '';
  String dimensions = '';
  String weight = '';
  bool operable = false;
  bool convertible = false;
  bool modified = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<BodyTypeResponse> bodytypes;

    Future<BodyTypeResponse?> getBodyType() async {
      var url = Uri.parse('${Constants.apiUrl}vehicle/bodytypes');

      var response = await http.get(
        url,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
      );
      final optionsResponse = BodyTypeResponse.fromRawJson(response.body);
      return optionsResponse;
    }

    String dropdownValue = 'Coupe';

    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: const [
              Text(
                "LIST A SHIPMENT",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(
            height: 10,
            color: Colors.white,
          ),
          DropdownButton<String>(
            hint: Text('Body type'),
            borderRadius: BorderRadius.circular(10),

            icon: const Icon(Icons.arrow_downward),
            iconSize: 20,
            //elevation: 16,
            //style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 1,
              color: Colors.grey,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['Coupe', 'Two', 'Free', 'Four']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          const Divider(
            height: 10,
            color: Colors.white,
          ),
          Container(
            alignment: Alignment.center,
            height: 150,
            width: 200,
            child: Image.asset('assets/bodytypes/coupe.png'),
          ),
          Container(
            color: Colors.amber[30],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Average Dimensions',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '4.62m x 1.42m x 1.78m',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'Average Weight',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '550kg',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Shipment Title'),
              hintText: 'What type of furniture? i.e couch, chair',
              hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
              filled: true,
              isDense: true,
            ),
            onChanged: (value) {
              // _title = value;
            },
            keyboardType: TextInputType.text,
            autocorrect: false,
          ),
          const Divider(
            height: 20,
            color: Colors.white,
          ),
          TextFormField(
            maxLines: 3,
            decoration: const InputDecoration(
              label: Text('Add description'),
              //hintText: 'What type of furniture? i.e couch, chair',
              hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
              filled: true,
              isDense: true,
            ),
            onChanged: (value) {
              //_description = value;
            },
            keyboardType: TextInputType.text,
            autocorrect: false,
          ),
          const Divider(
            height: 20,
            color: Colors.white,
          ),
          ElevatedButton(
              onPressed: () {
                //createListing(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewMovePage(
                              seleted: 'hola',
                            )));
              },
              child: const Text("Continue")),
        ],
      ),
    );
  }

  void createListing(BuildContext context) async {
    Map<String, dynamic> request = {
      //"title": _title,
      //"description": _description,
      //"commodity": _type
    };

    var url = Uri.parse('${Constants.apiUrl}listings');

    var response = await http.post(
      url,
      body: jsonEncode(request),
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer ${widget.token.token}'
      },
    );
    var body = response.body;
    var decodedJson = jsonDecode(body);
    //var listing = CreateListingResponse.fromJson(decodedJson);

    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => DimesionsDetails()));
  }
}

class TrailersPage extends StatelessWidget {
  const TrailersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Trailers Page to List"),
      ),
    );
  }
}

class VehiclePartsPage extends StatelessWidget {
  const VehiclePartsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("VehicleParts Page to List"),
      ),
    );
  }
}

class AirplanesPage extends StatelessWidget {
  const AirplanesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Airplanes Page to List"),
      ),
    );
  }
}
