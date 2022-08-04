import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/domain/entities/models/commodities/commodities_models.dart';

import 'package:my_app/models/commodities.dart';
import 'package:my_app/models/listing/response.dart';
import 'package:my_app/models/token.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/src/services/images_repository.dart';
import '../../../services/data_services.dart';
import 'dimensions_details.dart';

class InitialForm extends StatefulWidget {
  final Token token;
  final CommodityDetails seleted;
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

  String? photo = '';

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
          TextButton(
              onPressed: () {
                print(widget.subCommoditySeleted);
                //showModalBottomSheet(
                //   context: context, builder: (builder) => bottonSheet());
              },
              child: const Text('Add image')),
          const Divider(
            height: 20,
            color: Colors.white,
          ),
          ElevatedButton(
              onPressed: () {
                if (widget.subCommoditySeleted.toString() == 'Furnitures') {
                  setState(() {
                    photo = HouseholdImageRepository.furnituremage.toString();
                  });
                } else if (widget.subCommoditySeleted.toString() ==
                    'Home Electronics') {
                  setState(() {
                    photo = HouseholdImageRepository.electronicImage.toString();
                  });
                } else if (widget.subCommoditySeleted.toString() ==
                    'Appliances') {
                  setState(() {
                    photo =
                        HouseholdImageRepository.appliancesCarImage.toString();
                  });
                } else if (widget.subCommoditySeleted.toString() ==
                    'Outdoor Equipment') {
                  setState(() {
                    photo = HouseholdImageRepository.outdoorImage.toString();
                  });
                } else if (widget.subCommoditySeleted.toString() ==
                    'Sporting Equipment') {
                  setState(() {
                    photo = HouseholdImageRepository.sportingImage.toString();
                  });
                } else if (widget.subCommoditySeleted.toString() == 'Pianos') {
                  setState(() {
                    photo = HouseholdImageRepository.painosImage.toString();
                  });
                }

                //if (_key.currentState!.validate()) {}

                createListing(context);
              },
              child: const Text("Continue")),
        ],
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
      "photo": photo
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

    if (listing.listing.comodity == 'household') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SecondFormDetails(
                    listing: listing.listing,
                    token: widget.token,
                  )));
    }
  }
}
