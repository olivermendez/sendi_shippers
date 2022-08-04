import 'package:flutter/material.dart';
import 'package:my_app/domain/entities/models/commodities/commodities_models.dart';
import 'package:my_app/models/commodities.dart';
import 'package:my_app/models/token.dart';

import 'dropdown.dart';

class VehiclePartsPage extends StatelessWidget {
  final CommodityDetails seleted;
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(subCommoditySeleted),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              HandlingUnit(),
              FormDetailsATVS(
                token: token,
              )
            ],
          ),
        ));
  }
}

class FormDetailsATVS extends StatefulWidget {
  final Token token;
  const FormDetailsATVS({required this.token, Key? key}) : super(key: key);

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'DIMENSIONS DETAILS',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
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
          const Divider(
            height: 20,
            color: Colors.white,
          ),
          const Divider(),
          Row(
            children: <Widget>[
              const Expanded(child: Text('Quantity:')),
              Expanded(
                  child: TextFormField(
                controller: _weight,
                decoration: const InputDecoration(
                  label: Text(
                    'unit count',
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
          ),
        ],
      ),
    );
  }
}
