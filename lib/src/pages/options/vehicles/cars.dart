import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/config/constant.dart';
import 'package:my_app/models/bodytypes.dart';
import 'package:my_app/models/listing/listing.dart';
import 'package:my_app/models/listing/response.dart';
import 'package:my_app/models/token.dart';

import 'package:http/http.dart' as http;

class SendVehicle extends StatefulWidget {
  final Bodytype bodySeleted;
  final Token token;
  final String image;
  const SendVehicle(
      {required this.token,
      required this.bodySeleted,
      required this.image,
      Key? key})
      : super(key: key);

  @override
  State<SendVehicle> createState() => _SendVehicle();
}

class _SendVehicle extends State<SendVehicle> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(" Moving: " + widget.bodySeleted.value),
        backgroundColor: const Color.fromRGBO(3, 9, 23, 1),
        elevation: 0,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: widget.bodySeleted.details.length,
          itemBuilder: (context, index) {
            final opt = widget.bodySeleted.details[index];

            return selectYourBodyTypeListView(
                opt, widget.image, widget.token, context, widget.bodySeleted);
          },
        ),
      ),
    );
  }
}

Widget selectYourBodyTypeListView(Detail opt, String image, Token token,
    BuildContext context, Bodytype bodytypeSeleted) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Row(children: [
        Expanded(
          child: Container(
            color: Colors.amber[30],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Average Dimensions',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    opt.dimensions,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Text(
                    'Average Weight',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    opt.weight,
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
                image: AssetImage("assets/bodytypes/$image"),
              )),
        ),
      ]),
      const Divider(),
      vehicleInitialForm(
        token: token,
        image: image,
        dimension: opt.dimensions,
        weight: opt.weight,
        bodytypeSeleted: bodytypeSeleted,
      )
    ],
  );
}

class vehicleInitialForm extends StatefulWidget {
  Bodytype bodytypeSeleted;
  Token token;
  String image;
  String dimension;
  String weight;
  vehicleInitialForm(
      {required this.token,
      required this.image,
      required this.dimension,
      required this.weight,
      required this.bodytypeSeleted,
      Key? key})
      : super(key: key);

  @override
  _vehicleInitialFormState createState() => _vehicleInitialFormState();
}

class _vehicleInitialFormState extends State<vehicleInitialForm> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: _title,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "add title";
                }
                return null;
              },
              decoration: const InputDecoration(
                label: Text('Shipment Title'),
                helperText: 'e.g. 2015 Chevrolet Master',
                hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                filled: true,
                isDense: true,
              ),
              keyboardType: TextInputType.text,
              autocorrect: false,
            ),
            const Divider(
              height: 10,
              color: Colors.white,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "add quantity";
                }
                return null;
              },
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "add description";
                }
                return null;
              },
              controller: _description,
              maxLines: 3,
              decoration: const InputDecoration(
                label: Text('Add description'),
                helperText:
                    'Instructions you would like to give to your mover?',
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
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {}
                        InitialListingCreated(
                          _title.text,
                          _description.text,
                          _quantity.text,
                          'vehicles',
                          'cars',
                          widget.token,
                          widget.bodytypeSeleted,
                        );
                      },
                      child: const Text("Continue")),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> InitialListingCreated(
    String _title,
    String _description,
    String _quantity,
    String _comodity,
    String _subcomodity,
    Token token,
    Bodytype bodytypeSeleted,
  ) async {
    Map<String, dynamic> request = {
      "title": _title,
      "description": _description,
      "quantity": _quantity,
      "comodity": _comodity,
      "subcomodity": _subcomodity,
    };

    //var url = Uri.parse('${Constants.apiUrl}listings/${token.user.id}/vehicle');
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
    var listing = ListingResponse.fromJson(decodedJson);
    print(listing.listing.id);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConfirmVehicleListing(
                  averageDimensions: widget.dimension,
                  averageWeight: widget.weight,
                  listingCreated: listing.listing,
                  bodytypeSeleted: bodytypeSeleted,
                  token: token,
                )));
  }
}

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
      appBar: AppBar(
        title: const Text('Confirmation'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: SizedBox(
                  height: 300,
                  width: 300,
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
              //Text('Title'),
              Text(
                listingCreated.title,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              //Text(description),
              //Text(quantity),
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

    Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false,
        arguments: token);
    /* var body = response.body;
    var decodedJson = jsonDecode(body);
    var listing = ListingResponse.fromJson(decodedJson);
    print(listing.listing.id); */
  }
}
