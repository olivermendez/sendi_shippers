import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/config/constant.dart';
import 'package:my_app/models/commodities.dart';
import 'package:my_app/models/listing/response.dart';
import 'package:my_app/models/token.dart';
import 'package:http/http.dart' as http;

import 'dimensions.dart';

class ATVSPage extends StatelessWidget {
  final Commodity seleted;
  final String subCommoditySeleted;
  final Token token;
  const ATVSPage(
      {Key? key,
      required this.seleted,
      required this.subCommoditySeleted,
      required this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(subCommoditySeleted),
        ),
        body: InitialForm(
          token: token,
          seleted: seleted,
          subCommoditySeleted: subCommoditySeleted,
        ));
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
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
            TextButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context, builder: (builder) => bottonSheet());
                },
                child: const Text('Add image')),
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
      ),
    );
  }

  Widget bottonSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Choose Listing Photo',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Gallery Photo'),
              ),
              TextButton(onPressed: () {}, child: const Text('Camera'))
            ],
          )
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

    if (listing.listing.comodity == 'vehicles') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FormDetailsATVS(
                    listing: listing.listing,
                    token: widget.token,
                  )));
    }
  }
}
