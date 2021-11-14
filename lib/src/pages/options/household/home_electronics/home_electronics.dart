import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/config/constant.dart';
import 'package:my_app/models/commodities.dart';
import 'package:my_app/models/listing/listing.dart';
import 'package:my_app/models/listing/response.dart';
import 'package:my_app/models/token.dart';

import 'package:http/http.dart' as http;

class HomeElectronicsPage extends StatelessWidget {
  final Token token;
  final Commodity selected;
  final String subCommoditySeleted;

  const HomeElectronicsPage({
    required this.token,
    Key? key,
    required this.selected,
    required this.subCommoditySeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: InitialForm(
          token: token,
          seleted: selected,
          subCommoditySeleted: subCommoditySeleted,
        ),
      ),
    );
  }
}

class InitialForm extends StatefulWidget {
  final Token token;
  final Commodity seleted;
  final String subCommoditySeleted;

  const InitialForm({
    required this.token,
    Key? key,
    required this.seleted,
    required this.subCommoditySeleted,
  }) : super(key: key);

  @override
  State<InitialForm> createState() => _InitialFormState();
}

class _InitialFormState extends State<InitialForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _quantity = TextEditingController();

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
            controller: _title,
            decoration: const InputDecoration(
              label: Text('Shipment Title'),
              hintText: 'What type of furniture? i.e couch, chair',
              hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
              filled: true,
              isDense: true,
            ),
            keyboardType: TextInputType.text,
            autocorrect: false,
          ),
          const Divider(
            height: 20,
            color: Colors.white,
          ),
          TextFormField(
            controller: _quantity,
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
            controller: _description,
            maxLines: 3,
            decoration: const InputDecoration(
              label: Text('Add description'),
              hintText: 'Instructions you would like to give to your mover?',
              hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
              filled: true,
              isDense: true,
            ),
            keyboardType: TextInputType.text,
            autocorrect: false,
          ),
          const Divider(
            height: 20,
            color: Colors.white,
          ),
          ElevatedButton(
              onPressed: () async {
                //TODO: Validar datos ingresados por el usuario.
                await createListing(context);
              },
              child: const Text("Continue")),
        ],
      ),
    );
  }

  Future<void> createListing(BuildContext context) async {
    Map<String, dynamic> request = {
      "title": _title.text,
      "description": _description.text,
      "quantity": _quantity.text,
      "commodity": widget.seleted.label,
      "subcomodity": widget.subCommoditySeleted,
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
            builder: (context) => SecondFormDetails(
                  listing: listing.listing,
                  token: widget.token,
                )));
  }
}

class SecondFormDetails extends StatefulWidget {
  final Listing listing;

  final Token token;
  SecondFormDetails({required this.listing, required this.token, Key? key})
      : super(key: key);

  @override
  State<SecondFormDetails> createState() => _SecondFormDetailsState();
}

class _SecondFormDetailsState extends State<SecondFormDetails> {
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
    print("controller: " + _length.text);

    length = int.parse(_length.text);
    width = int.parse(_width.text);
    height = int.parse(_height.text);
    weight = int.parse(_weight.text);

    print(length);
    //TODO: por alguna razon el lenght no llega al db

    Map<String, dynamic> request = {
      "length:": length,
      "width": width,
      "height": height,
      "weight": weight,
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

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ThirdFormLocations(
                listingCreated: widget.listing, token: widget.token)));
  }
}

class ThirdFormLocations extends StatefulWidget {
  final Listing listingCreated;
  final Token token;
  ThirdFormLocations(
      {required this.listingCreated, required this.token, Key? key})
      : super(key: key);

  @override
  _ThirdFormLocationsState createState() => _ThirdFormLocationsState();
}

class _ThirdFormLocationsState extends State<ThirdFormLocations> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Locations"),
        centerTitle: false,
        backgroundColor: Colors.black87,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Text(
              "You will move: " + widget.listingCreated.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: _key,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Pick up location',
                          filled: true,
                          isDense: true,
                          //icon: Icon(
                          //Icons.location_on,
                          //size: 30,
                          //)
                        ),
                        keyboardType: TextInputType.streetAddress,
                        autocorrect: false,
                      ),
                      const Divider(
                        height: 30,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Delivery location',
                          filled: true,
                          isDense: true,
                          /* icon: Icon(
                        Icons.where_to_vote,
                        size: 30,
                      ) */
                        ),
                        keyboardType: TextInputType.streetAddress,
                        autocorrect: false,
                      ),
                      const Divider(
                        height: 40,
                      ),
                      const Text("When do you need your shitment deliver?",
                          style: TextStyle(fontSize: 17)),
                      TextFormField(
                        decoration: const InputDecoration(
                          //labelText: 'Delivery location',
                          filled: true,
                          isDense: true,
                          hintText: 'M/D/YYYY',
                          /*  icon: Icon(
                        Icons.schedule,
                        size: 30,
                      ) */
                        ),
                        keyboardType: TextInputType.datetime,
                        autocorrect: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'home', (route) => false,
                                  arguments: widget.token);
                            },
                            child: const Text("Continue")),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
