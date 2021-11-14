import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/config/constant.dart';
import 'package:my_app/models/listing/response.dart';
import 'package:my_app/models/token.dart';
import 'package:http/http.dart' as http;
import 'dimensions_details.dart';

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
