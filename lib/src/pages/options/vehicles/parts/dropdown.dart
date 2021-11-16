import 'package:flutter/material.dart';

class HandlingUnit extends StatefulWidget {
  @override
  createState() {
    return HandlingUnitState();
  }
}

class HandlingUnitState extends State<HandlingUnit> {
  int? _value = 1;
  int? _dropvalue = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            'HANDLING UNIT',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: () => setState(
                  () => _value = 1,
                ),
                child: Container(
                  color: _value == 1 ? Colors.grey[200] : Colors.transparent,
                  child: ListTile(
                    title: const Text('Box'),
                    leading: Image.asset('assets/parts/box.png'),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => setState(() => _value = 2),
                child: Container(
                  color: _value == 2 ? Colors.grey[200] : Colors.transparent,
                  child: ListTile(
                    title: const Text('Pallet'),
                    leading: Image.asset('assets/parts/pallet.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(children: [
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _value = 3),
              child: Container(
                color: _value == 3 ? Colors.grey[200] : Colors.transparent,
                child: ListTile(
                  title: const Text('Crate'),
                  leading: Image.asset('assets/parts/crate.png'),
                ),
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: DropdownButton(
              value: _dropvalue,
              items: const [
                DropdownMenuItem(
                  child: Text('Box'),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text('Pallet'),
                  value: 2,
                ),
                DropdownMenuItem(
                  child: Text('Crate'),
                  value: 3,
                ),
              ],
              onChanged: (int? value) {
                setState(() {
                  _dropvalue = value;
                  _value = value;
                });
              },
              hint: const Text('Select'),
            ),
          ))
        ])
      ],
    );
  }

  Widget optionsSelected() {
    int _value = 0;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => setState(() => _value = 0),
            child: Container(
              height: 56,
              width: 56,
              color: _value == 0 ? Colors.grey : Colors.transparent,
              child: Icon(Icons.call),
            ),
          ),
          SizedBox(width: 4),
          GestureDetector(
            onTap: () => setState(() => _value = 1),
            child: Container(
              height: 56,
              width: 56,
              color: _value == 1 ? Colors.grey : Colors.transparent,
              child: Icon(Icons.message),
            ),
          ),
        ],
      ),
    );
  }
}
