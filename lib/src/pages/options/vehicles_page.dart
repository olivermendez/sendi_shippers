import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/config/constant.dart';
import 'package:my_app/models/commodities.dart';

import 'package:http/http.dart' as http;
import 'package:my_app/models/token.dart';

class VehiclePageForm extends StatefulWidget {
  final Commodity seleted;
  final String item;
  const VehiclePageForm(
      {required this.seleted, required this.item, Key? key, String? label})
      : super(key: key);

  static String routeName = 'vehicles';

  @override
  State<VehiclePageForm> createState() => _VehiclePageFormState();
}

class _VehiclePageFormState extends State<VehiclePageForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Moving: " + widget.item,
          style: TextStyle(fontSize: 17),
        ),
        backgroundColor: Colors.black87,
        centerTitle: false,
      ),
      body: addDynamic(widget.item),
    );
  }
}

addDynamic(String item) {
  if (item == 'Cars & Light Trucks') {
    return const CarsAndLightTrucksPage();
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

class NewMove extends StatefulWidget {
  final Token token;
  const NewMove({required this.token, Key? key}) : super(key: key);

  @override
  State<NewMove> createState() => _NewMoveState();
}

class _NewMoveState extends State<NewMove> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String? _title;

  String? _description;

  int _quantity = 0;

  final String _type = 'Furniture';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: const [
              Text(
                "List Shipment",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(
            height: 20,
            color: Colors.white,
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Shipment Title'),
              hintText: 'What type of furniture? i.e couch, chair',
              hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
              filled: true,
              isDense: true,
            ),
            onChanged: (value) {
              _title = value;
            },
            keyboardType: TextInputType.text,
            autocorrect: false,
          ),
          const Divider(
            height: 20,
            color: Colors.white,
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Quantity'),
              hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
              filled: true,
              isDense: true,
            ),
            keyboardType: TextInputType.number,
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
              _description = value;
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
                createListing(context);
              },
              child: const Text("Continue")),
        ],
      ),
    );
  }

  void createListing(BuildContext context) async {
    Map<String, dynamic> request = {
      "title": _title,
      "description": _description,
      "commodity": _type
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

class CarsAndLightTrucksPage extends StatelessWidget {
  const CarsAndLightTrucksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("CarsAndLightTrucks Page to List"),
      ),
    );
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
