import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/config/constant.dart';
import 'package:my_app/models/commodities.dart';
import 'package:my_app/models/listing.dart';
import 'package:my_app/models/token.dart';

import 'package:http/http.dart' as http;
import 'package:my_app/src/pages/dimesions_detail_page.dart';

class HouseHoldGoodsPage extends StatelessWidget {
  final Token token;
  final Commodity seleted;
  final String item;
  const HouseHoldGoodsPage(
      {required this.seleted,
      required this.item,
      required this.token,
      Key? key,
      String? label})
      : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Move: " + item,
          style: const TextStyle(fontSize: 17),
        ),
        backgroundColor: Colors.black87,
        centerTitle: false,
      ),
      body: addDynamic(item, token),
    );
  }
}

addDynamic(String item, Token token) {
  if (item == 'Furniture') {
    return FurnituresPage(
      token: token,
    );
  } else if (item == 'Home Electronics') {
    return HomeElectronicsPage(
      token: token,
    );
  } else if (item == 'Appliances') {
    return AppliancesPage(
      token: token,
    );
  } else if (item == 'Arcade Equipment') {
    return ArcadeEquipmentPage(
      token: token,
    );
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

class FurnituresPage extends StatelessWidget {
  final Token token;
  const FurnituresPage({required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: NewMove(
            token: token,
          ),
        ),
      ),
    );
  }
}

class HomeElectronicsPage extends StatelessWidget {
  final Token token;
  const HomeElectronicsPage({required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: NewMove(
            token: token,
          ),
        ),
      ),
    );
  }
}

class AppliancesPage extends StatelessWidget {
  final Token token;
  const AppliancesPage({required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: NewMove(
            token: token,
          ),
        ),
      ),
    );
  }
}

class ArcadeEquipmentPage extends StatelessWidget {
  final Token token;
  const ArcadeEquipmentPage({required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: NewMove(
          token: token,
        ),
      )),
    );
  }
}

class OutdoorEquipmentPage extends StatelessWidget {
  final Token token;
  const OutdoorEquipmentPage({required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: NewMove(
          token: token,
        ),
      )),
    );
  }
}

class SportingEquipmentPage extends StatelessWidget {
  final Token token;
  const SportingEquipmentPage({required this.token, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: NewMove(
            token: token,
          ),
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
                //TODO: Validar datos ingresados por el usuario.
                createListing(context);
              },
              child: const Text("Continue")),
        ],
      ),
    );
  }

  Future<void> createListing(BuildContext context) async {
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
    var listing = CreateListingResponse.fromJson(decodedJson);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DimesionsDetails(
                  listing: listing.listing,
                  token: widget.token,
                )));
  }
}
