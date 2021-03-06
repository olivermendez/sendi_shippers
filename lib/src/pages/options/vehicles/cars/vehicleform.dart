import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/models/bodytypes.dart';
import 'package:my_app/models/listing/response.dart';
import 'package:my_app/models/token.dart';

import 'package:http/http.dart' as http;

import '../../../../services/data_services.dart';
import '../../../../services/images_repository.dart';
import 'confirm_listing.dart';

// ignore: must_be_immutable
class VehicleInitialForm extends StatefulWidget {
  Bodytype bodytypeSeleted;
  Token token;
  String image;
  String dimension;
  String weight;
  VehicleInitialForm(
      {required this.token,
      required this.image,
      required this.dimension,
      required this.weight,
      required this.bodytypeSeleted,
      Key? key})
      : super(key: key);

  @override
  _VehicleInitialFormState createState() => _VehicleInitialFormState();
}

class _VehicleInitialFormState extends State<VehicleInitialForm> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _quantity = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String? photo = '';

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
            TextButton(
                onPressed: () {
                  /*
                  print(widget.bodytypeSeleted.image.toString());
                  showModalBottomSheet(
                      context: context, builder: (builder) => bottonSheet());

                      */
                },
                child: const Text('Add image')),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {}

                        photo = getImage(widget.bodytypeSeleted.image);

                        InitialListingCreated(
                          _title.text,
                          _description.text,
                          _quantity.text,
                          'vehicles',
                          'cars',
                          widget.token,
                          photo.toString(),
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

  // ignore: non_constant_identifier_names
  Future<void> InitialListingCreated(
    final String _title,
    final String _description,
    final String _quantity,
    final String _comodity,
    final String _subcomodity,
    final Token token,
    final String photo,
    Bodytype bodytypeSeleted,
  ) async {
    Map<String, dynamic> request = {
      "title": _title,
      "description": _description,
      "quantity": _quantity,
      "comodity": _comodity,
      "subcomodity": _subcomodity,
      "photo": photo,
    };
    print(photo);

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

String? getImage(String code) {
  String photo = "";

  //TODO: Change this validation with SwithCase, for better performance

  if (code == 'coupe.png') {
    return photo = CarsImageRepository.coupeImage;
  } else if (code == 'hatchback.png') {
    return photo = CarsImageRepository.hatchImage;
  } else if (code == 'microcar.png') {
    return photo = CarsImageRepository.microCarImage;
  } else if (code == 'minivan.png') {
    return photo = CarsImageRepository.vanImage;
  } else if (code == 'pickupfullsize.png') {
    return photo = CarsImageRepository.pickupfullImage;
  } else if (code == 'pickupmidsize.png') {
    return photo = CarsImageRepository.pickupmidImage;
  } else if (code == 'sedan.png') {
    return photo = CarsImageRepository.sedanImage;
  } else if (code == 'stationwagon.png') {
    return photo = CarsImageRepository.wagonImage;
  }
}
