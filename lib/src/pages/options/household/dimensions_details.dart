import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/models/listing/listing.dart';
import 'package:my_app/models/token.dart';

import 'package:http/http.dart' as http;

import '../../../services/data_services.dart';
import '../locations.dart';

class SecondFormDetails extends StatefulWidget {
  final Listing listing;

  final Token token;
  const SecondFormDetails(
      {required this.listing, required this.token, Key? key})
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
            builder: (context) => LocationsPage(
                  listingCreated: widget.listing,
                  token: widget.token,
                )));
  }
}
