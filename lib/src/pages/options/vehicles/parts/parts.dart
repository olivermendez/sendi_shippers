import 'package:flutter/material.dart';
import 'package:my_app/models/commodities.dart';
import 'package:my_app/models/listing/listing.dart';
import 'package:my_app/models/token.dart';

import 'dropdown.dart';

class VehiclePartsPage extends StatelessWidget {
  final Commodity seleted;
  final String subCommoditySeleted;
  final Token token;
  const VehiclePartsPage(
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
        body: Column(
          children: [
            CustomRadio(),
          ],
        ));
  }
}

class FormDetailsATVS extends StatefulWidget {
  final Listing listing;
  final Token token;

  FormDetailsATVS({required this.listing, required this.token, Key? key})
      : super(key: key);

  @override
  State<FormDetailsATVS> createState() => _FormDetailsATVSState();
}

class _FormDetailsATVSState extends State<FormDetailsATVS> {
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
            Image.asset('assets/atvs.png'),
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
                      onPressed: () {}, child: const Text("Continue")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
