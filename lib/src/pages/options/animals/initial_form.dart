import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/models/listing/response.dart';
import 'package:my_app/models/motorbodytypes.dart';
import 'package:my_app/models/token.dart';

import 'package:http/http.dart' as http;
import 'package:my_app/src/services/images_repository.dart';

import '../../../services/data_services.dart';
import '../locations.dart';

class AnimalsForm extends StatefulWidget {
  final String subCommoditySeleted;
  final Token token;

  const AnimalsForm(
      {Key? key, required this.subCommoditySeleted, required this.token})
      : super(key: key);

  @override
  _AnimalsFormState createState() => _AnimalsFormState();
}

class _AnimalsFormState extends State<AnimalsForm> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "List Animals for transport",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                controller: _title,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "add title";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text(widget.subCommoditySeleted + ' name'),
                  helperText: 'Example, Laky, shubi',
                  hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
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
                  label: Text('Add all information about your pet'),
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

                          String? photo = getImage(widget.subCommoditySeleted);

                          InitialListingCreated(
                            _title.text,
                            _description.text,
                            _quantity.text,
                            'animals',
                            'pet',
                            widget.token,
                            photo.toString(),
                          );
                          //print(photo);
                        },
                        child: const Text("Continue")),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

/*
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

  */

  Future<void> InitialListingCreated(
    String _title,
    String _description,
    String _quantity,
    String _comodity,
    String _subcomodity,
    Token token,
    String photo,
  ) async {
    Map<String, dynamic> request = {
      "title": _title,
      "description": _description,
      "quantity": _quantity,
      "comodity": _comodity,
      "subcomodity": _subcomodity,
      "photo": photo
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
        builder: (context) => LocationsPage(
          listingCreated: listing.listing,
          token: token,
        ),
      ),
    );
  }
}

String? getImage(String code) {
  String photo = "";

  //TODO: Change this validation with SwithCase, for better performance

  if (code == 'Dual-Sport') {
    //return photo = AnimalsImageRepository.dualImage.toString();
  } else if (code == 'Cats') {
    return photo = AnimalsImageRepository.catImage;
  } else if (code == 'Dogs') {
    return photo = AnimalsImageRepository.dogImage;
  } else if (code == 'Horses') {
    return photo = AnimalsImageRepository.horsesImage;
  }
}
