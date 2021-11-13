import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/config/constant.dart';
import 'package:my_app/models/commodities.dart';
import 'package:my_app/models/listing/listing.dart';
import 'package:my_app/models/listing/response.dart';
import 'package:my_app/models/token.dart';

import 'package:http/http.dart' as http;
import 'package:my_app/src/pages/listing_locations.dart';

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

  String? _quantity;

  final String _comodity = 'household';
  final String _subcomodity = 'furniture';

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
            onChanged: (value) {
              _quantity = value;
            },
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
              hintText: 'Instructions you would like to give to your mover?',
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
      "quantity": _quantity,
      "commodity": _comodity,
      "subcomodity": _subcomodity,
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
    var listing = ListingResponse.fromJson(decodedJson);
    print(listing.listing.id);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DimesionsDetails(
                  listing: listing.listing,
                  token: widget.token,
                )));
  }
}

class DimesionsDetails extends StatefulWidget {
  final Listing listing;

  final Token token;
  DimesionsDetails({required this.listing, required this.token, Key? key})
      : super(key: key);

  @override
  State<DimesionsDetails> createState() => _DimesionsDetailsState();
}

class _DimesionsDetailsState extends State<DimesionsDetails> {
  final TextEditingController _length = TextEditingController();

  final TextEditingController _width = TextEditingController();

  final TextEditingController _height = TextEditingController();

  final TextEditingController _weight = TextEditingController();

  late int length, width, height, weight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Dimensions Details'),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/dimensions.png'),
            const Divider(),
            Row(
              children: <Widget>[
                const Expanded(child: Text('Length:')),
                Expanded(
                    child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _length,
                  decoration: const InputDecoration(
                    label: Text(
                      'cm',
                      style: TextStyle(fontSize: 15),
                    ),
                    filled: true,
                    isDense: true,
                  ),
                )),
              ],
            ),
            const Divider(),
            Row(
              children: <Widget>[
                const Expanded(child: Text('Width:')),
                Expanded(
                    child: TextFormField(
                  controller: _width,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text(
                      'cm',
                      style: TextStyle(fontSize: 15),
                    ),
                    filled: true,
                    isDense: true,
                  ),
                )),
              ],
            ),
            const Divider(),
            Row(
              children: <Widget>[
                const Expanded(child: Text('Height:')),
                Expanded(
                    child: TextFormField(
                  controller: _height,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text(
                      'cm',
                      style: TextStyle(fontSize: 15),
                    ),
                    filled: true,
                    isDense: true,
                  ),
                )),
              ],
            ),
            const Divider(),
            Row(
              children: <Widget>[
                const Expanded(child: Text('Weight:')),
                Expanded(
                    child: TextFormField(
                  controller: _weight,
                  decoration: const InputDecoration(
                    label: Text(
                      'kg',
                      style: TextStyle(fontSize: 15),
                    ),
                    filled: true,
                    isDense: true,
                  ),
                )),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        createDimesions(context);
                      },
                      child: const Text("Continue")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> createDimesions(BuildContext context) async {
    print("controller" + _length.text);

    length = int.parse(_length.text);
    width = int.parse(_width.text);
    height = int.parse(_height.text);
    weight = int.parse(_weight.text);

    print(length);
    //TODO: por alguna razon el lenght no llega al db

    Map<String, dynamic> request = {
      "width": width,
      "height": height,
      "weight": weight,
      "length:": length,
    };

    print(length);

    var url =
        Uri.parse('${Constants.apiUrl}listings/${widget.listing.id}/furniture');

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
    print(body);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewMovePage(
                  //listing: widget.listing,
                  seleted: body,
                )));
  }
}

class Confirmation extends StatelessWidget {
  final Listing listing;
  String body;
  Confirmation({required this.listing, required this.body, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dimensions = jsonDecode(body);
    var length = dimensions['data']['length'].toString();
    var width = dimensions['data']['width'].toString();
    var height = dimensions['data']['height'].toString();
    var weight = dimensions['data']['weight'].toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(length),
            Text(width),
            Text(height),
            Text(weight),
          ],
        ),
      ),
    );
  }
}
