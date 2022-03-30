import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:my_app/config/constant.dart';
import 'package:my_app/models/bodytypes.dart';
import 'package:my_app/models/listing/response.dart';
import 'package:my_app/models/token.dart';

import 'package:http/http.dart' as http;

import '../../../../services/data_services.dart';
import 'confirm_listing.dart';

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
                  print(widget.bodytypeSeleted.image.toString());
                  showModalBottomSheet(
                      context: context, builder: (builder) => bottonSheet());
                },
                child: const Text('Add image')),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {}

                        if (widget.bodytypeSeleted.image.toString() ==
                            'coupe.png') {
                          setState(() {
                            photo = ImageRepository.coupeImage.toString();
                          });
                        } else if (widget.bodytypeSeleted.image.toString() ==
                            'hatchback.png') {
                          setState(() {
                            photo = ImageRepository.hatchImage.toString();
                          });
                        } else if (widget.bodytypeSeleted.image.toString() ==
                            'microcar.png') {
                          setState(() {
                            photo = ImageRepository.microCarImage.toString();
                          });
                        } else if (widget.bodytypeSeleted.image.toString() ==
                            'minivan.png') {
                          setState(() {
                            photo = ImageRepository.vanImage.toString();
                          });
                        } else if (widget.bodytypeSeleted.image.toString() ==
                            'pickupfullsize.png') {
                          setState(() {
                            photo = ImageRepository.pickupdutyImage.toString();
                          });
                        } else if (widget.bodytypeSeleted.image.toString() ==
                            'pickupmidsize.png') {
                          setState(() {
                            photo = ImageRepository.pickupmidImage.toString();
                          });
                        } else if (widget.bodytypeSeleted.image.toString() ==
                            'sedan.png') {
                          setState(() {
                            photo = ImageRepository.sedanImage.toString();
                          });
                        } else if (widget.bodytypeSeleted.image.toString() ==
                            'stationwagon.png') {
                          setState(() {
                            photo = ImageRepository.wagonImage.toString();
                          });
                        }

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

  Future<void> InitialListingCreated(
    final String _title,
    final String _description,
    final String _quantity,
    final String _comodity,
    final String _subcomodity,
    final Token token,
    final String _photo,
    Bodytype bodytypeSeleted,
  ) async {
    Map<String, dynamic> request = {
      "title": _title,
      "description": _description,
      "quantity": _quantity,
      "comodity": _comodity,
      "subcomodity": _subcomodity,
      "photo": _photo,
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

class ImageRepository {
  static const String coupeImage =
      "https://thumbs.dreamstime.com/b/white-coupe-sporty-car-background-side-view-isolated-path-generic-automobile-glossy-carbon-fiber-surface-123480025.jpg";
  static const String hatchImage =
      "https://i.pinimg.com/736x/1c/1d/8a/1c1d8a73041cc07c46110c382d966672.jpg";
  static const String microCarImage =
      "https://media.v2.siweb.es/uploaded_thumb_medium/bcecc58aa3df5f8e6e8e3b31230f28dd/microcar_due_young_light_00.png";
  static const String vanImage =
      "https://media.istockphoto.com/photos/modern-compact-minivan-picture-id626962038?k=20&m=626962038&s=612x612&w=0&h=15jpoKGRTdoxn6dzR07AIc3RD1Y2BocFNN9aOgfDiiM=";
  static const String pickupdutyImage = "";
  static const String pickupmidImage = "";
  static const String sedanImage = "";
  static const String wagonImage = "";
}

String getImageFromSpecificCar(String name) {
  String? photo = '';

  return photo;
}
