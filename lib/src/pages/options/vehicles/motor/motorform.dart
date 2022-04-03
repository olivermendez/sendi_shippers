import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/models/listing/response.dart';
import 'package:my_app/models/motorbodytypes.dart';
import 'package:my_app/models/token.dart';

import 'package:http/http.dart' as http;
import 'package:my_app/src/services/images_repository.dart';

import '../../../../services/data_services.dart';
import '../../locations.dart';

class MotorcyclesForm extends StatefulWidget {
  final Bodytypesmotor bodySeleted;
  final Token token;

  const MotorcyclesForm(
      {Key? key, required this.bodySeleted, required this.token})
      : super(key: key);

  @override
  _MotorcyclesFormState createState() => _MotorcyclesFormState();
}

class _MotorcyclesFormState extends State<MotorcyclesForm> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String? photo = '';

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
              const Text(
                "List Shipments",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
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
              TextButton(
                  onPressed: () {
                    print(widget.bodySeleted.value.toString());
                  },
                  child: const Text('Add image')),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          if (widget.bodySeleted.toString() == 'Dual-Sport') {
                            setState(() {
                              photo = MotorImageRepository.dualImage;
                            });
                          } else if (widget.bodySeleted.toString() ==
                              'Standard') {
                            setState(() {
                              photo = MotorImageRepository.standardImage;
                            });
                          } else if (widget.bodySeleted.toString() == 'Cabin') {
                            setState(() {
                              photo = MotorImageRepository.cabinImage;
                            });
                          } else if (widget.bodySeleted.toString() ==
                              'Cruiser') {
                            setState(() {
                              photo = MotorImageRepository.cruiserImage;
                            });
                          } else if (widget.bodySeleted.toString() == 'Moped') {
                            setState(() {
                              photo = MotorImageRepository.mopedImage;
                            });
                          } else if (widget.bodySeleted.toString() ==
                              'Off-Road') {
                            setState(() {
                              photo = MotorImageRepository.offroadImage;
                            });
                          } else if (widget.bodySeleted.toString() ==
                              'Scooter') {
                            setState(() {
                              photo = MotorImageRepository.scooterImage;
                            });
                          } else if (widget.bodySeleted.toString() ==
                              'Sport Bike') {
                            setState(() {
                              photo = MotorImageRepository.sportImage;
                            });
                          } else if (widget.bodySeleted.toString() ==
                              'Touring') {
                            setState(() {
                              photo = MotorImageRepository.touringImage;
                            });
                          }

                          if (_key.currentState!.validate()) {
                            InitialListingCreated(
                              _title.text,
                              _description.text,
                              _quantity.text,
                              'vehicles',
                              'motor',
                              widget.token,
                              widget.bodySeleted,
                              photo.toString(),
                            );
                          }
                          print(photo.toString());
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
    Bodytypesmotor bodytypeSeleted,
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
          //averageDimensions: widget.dimension,
          //averageWeight: widget.weight,
          listingCreated: listing.listing,
          //bodytypeSeleted: bodytypeSeleted,
          token: token,
        ),
      ),
    );
  }
}
