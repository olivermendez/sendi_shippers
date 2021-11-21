import 'package:flutter/material.dart';
import 'package:my_app/models/token.dart';
import 'package:my_app/src/pages/options/animals/second_form.dart';

class InitialFormAnimals extends StatefulWidget {
  final Token token;
  final String subCommoditySeleted;
  const InitialFormAnimals(
      {Key? key, required this.token, required this.subCommoditySeleted})
      : super(key: key);

  @override
  _InitialFormAnimalsState createState() => _InitialFormAnimalsState();
}

class _InitialFormAnimalsState extends State<InitialFormAnimals> {
  final _title = TextEditingController();
  final _petName = TextEditingController();
  final _petWeight = TextEditingController();
  final _petBreed = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String? hintText = 'e.g., Ellie and Annabel - Two Cute Puppies';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: _title,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label: const Text('Shipment Title'),
                    helperText: hintText,
                  )),
              TextFormField(
                  controller: _petName,
                  decoration: InputDecoration(
                    label: Text(widget.subCommoditySeleted + ' name'),
                  )),
              TextFormField(
                  controller: _petBreed,
                  decoration: InputDecoration(
                    label: Text(widget.subCommoditySeleted + ' Breed'),
                  )),
              TextFormField(
                  controller: _petWeight,
                  decoration: InputDecoration(
                      label: Text(widget.subCommoditySeleted + ' Weight'),
                      hintText: 'kg')),
              const Divider(),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SecondFormLocationAnimals(
                                          token: widget.token,
                                        )));
                          },
                          child: const Text('continue')))
                ],
              )
            ],
          )),
    );
  }
}
