import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/config/constant.dart';
import 'package:my_app/models/commodities.dart';
import 'package:my_app/models/listing_1.dart';
import 'package:my_app/models/token.dart';
import 'package:my_app/src/pages/confirmation_page.dart';

import 'package:http/http.dart' as http;

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

  //static const String routeName = 'houseitems';

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

class NewMove extends StatelessWidget {
  final Token token;
  NewMove({required this.token, Key? key}) : super(key: key);
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
                createListing();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DimesionsDetails()));
              },
              child: const Text("Continue")),
        ],
      ),
    );
  }

  void createListing() async {
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
        'Authorization': 'Bearer ${token.token}'
      },
    );
    var body = response.body;
    var decodedJson = jsonDecode(body);
    var listing = CreateListingResponse.fromJson(decodedJson);

    print(listing.listing.id);
  }
}

class DimesionsDetails extends StatelessWidget {
  const DimesionsDetails({Key? key}) : super(key: key);

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
            Container(
              child: Image.asset('assets/dimensions.png'),
            ),
            Divider(),
            Row(
              children: <Widget>[
                const Expanded(child: Text('Length:')),
                Expanded(
                    child: TextFormField(
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
            Divider(),
            Row(
              children: <Widget>[
                const Expanded(child: Text('Width:')),
                Expanded(
                    child: TextFormField(
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
            Divider(),
            Row(
              children: <Widget>[
                const Expanded(child: Text('Height:')),
                Expanded(
                    child: TextFormField(
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
            Divider(),
            Row(
              children: <Widget>[
                const Expanded(child: Text('Weight:')),
                Expanded(
                    child: TextFormField(
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
            Divider(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PricePage()));
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
}

class PricePage extends StatelessWidget {
  const PricePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('price'),
        ),
        body: Container());
  }
}

class NewFurnitureMove extends StatefulWidget {
  NewFurnitureMove({Key? key}) : super(key: key);

  @override
  State<NewFurnitureMove> createState() => _NewFurnitureMoveState();
}

class _NewFurnitureMoveState extends State<NewFurnitureMove> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "List Shipment",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(
            height: 20,
            color: Colors.white,
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Funiture Type'),
              hintText: 'What type of furniture? i.e couch, chair',
              hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
              filled: true,
              isDense: true,
            ),
            //controller: _username,
            keyboardType: TextInputType.streetAddress,
            autocorrect: false,
          ),
          const Divider(
            height: 20,
            color: Colors.white,
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    'LENGTH',
                    style: TextStyle(fontSize: 10),
                  ),
                  filled: true,
                  isDense: true,
                ),
              )),
              Expanded(
                  child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    'WIDTH',
                    style: TextStyle(fontSize: 10),
                  ),
                  filled: true,
                  isDense: true,
                ),
              )),
              Expanded(
                  child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    'HEIGHT',
                    style: TextStyle(fontSize: 10),
                  ),
                  filled: true,
                  isDense: true,
                ),
              )),
              Expanded(
                  child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    'Drop here',
                    style: TextStyle(fontSize: 10),
                  ),
                  filled: true,
                  isDense: true,
                ),
              )),
            ],
          ),
          const Divider(
            height: 20,
            color: Colors.white,
          ),
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    'WEIGHT',
                    style: TextStyle(fontSize: 10),
                  ),
                  filled: true,
                  isDense: true,
                ),
              )),
              Expanded(
                  child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    'Drop here',
                    style: TextStyle(fontSize: 10),
                  ),
                  filled: true,
                  isDense: true,
                ),
              )),
            ],
          ),
          const Divider(
            height: 20,
            color: Colors.white,
          ),
          Expanded(
              child: TextFormField(
            decoration: const InputDecoration(
              label: Text(
                'Quantity',
                style: TextStyle(fontSize: 10),
              ),
              filled: true,
              isDense: true,
            ),
          )),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PickUpLocationFromTo()));
              },
              child: const Text("Continue")),
        ],
      ),
    );
  }
}

class PickUpLocationFromTo extends StatefulWidget {
  PickUpLocationFromTo({Key? key}) : super(key: key);

  @override
  _PickUpLocationFromToState createState() => _PickUpLocationFromToState();
}

class _PickUpLocationFromToState extends State<PickUpLocationFromTo> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DATA'),
        backgroundColor: Colors.black87,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
            key: _key,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Pickup Location",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Divider(height: 20, color: Colors.white),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Pick up location',
                      filled: true,
                      isDense: true,
                    ),
                    //controller: _username,
                    keyboardType: TextInputType.streetAddress,
                    autocorrect: false,
                  ),
                  const Divider(height: 20, color: Colors.white),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Delivery location',
                      filled: true,
                      isDense: true,
                    ),
                    //controller: _username,
                    keyboardType: TextInputType.streetAddress,
                    autocorrect: false,
                  ),
                  const Divider(height: 40, color: Colors.white),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text("When do you need your shitment deliver?",
                        style: TextStyle(fontSize: 17)),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      //labelText: 'Delivery location',
                      filled: true,
                      isDense: true,
                      hintText: 'M/D/YYYY',
                    ),
                    //controller: _username,
                    keyboardType: TextInputType.datetime,
                    autocorrect: false,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfirmationPage()));
                        },
                        child: const Text("Continue")),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
