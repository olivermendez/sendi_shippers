import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/config/constant.dart';
import 'package:my_app/models/bodytypes.dart';
import 'package:my_app/models/token.dart';

import 'package:http/http.dart' as http;

class New extends StatefulWidget {
  final Bodytype bodySeleted;
  final Token token;
  final String image;
  const New(
      {required this.token,
      required this.bodySeleted,
      required this.image,
      Key? key})
      : super(key: key);

  @override
  State<New> createState() => _New();
}

class _New extends State<New> {
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
        backgroundColor: Color.fromRGBO(3, 9, 23, 1),
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
                opt, widget.image, widget.token, context);
          },
        ),
      ),
    );
  }
}

Widget selectYourBodyTypeListView(
    Detail opt, String image, Token token, BuildContext context) {
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
      vehicleInitialForm(token, image, context)
    ],
  );
}

Widget vehicleInitialForm(Token token, String image, BuildContext context) {
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _quantity = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  return Form(
      key: _key,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "add title";
                }
                return null;
              },
              controller: _title,
              decoration: const InputDecoration(
                label: Text('Shipment Title'),
                helperText: 'e.g. 2015 Chevrolet Master',
                hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                filled: true,
                isDense: true,
              ),
              onChanged: (value) {
                // _title = value;
              },
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
              onChanged: (value) {
                //_description = value;
              },
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
                        Conection().createListing(
                            _title.text,
                            _description.text,
                            _quantity.text,
                            'vehicles',
                            'cars',
                            token);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConfirmVehicleListing()));
                      },
                      child: const Text("Continue")),
                ),
              ],
            ),
          ],
        ),
      ));
}

class ConfirmVehicleListing extends StatelessWidget {
  const ConfirmVehicleListing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('confirmation'),
      ),
    );
  }
}

class Conection {
  Future<void> createListing(
      String _title,
      String _description,
      String _quantity,
      String _comodity,
      String _subcomodity,
      Token token) async {
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
  }
}
