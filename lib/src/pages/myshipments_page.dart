import 'package:flutter/material.dart';
import 'package:my_app/models/token.dart';
import 'package:my_app/widgets/shipper_drawer.dart';

class MyShipmentPage extends StatelessWidget {
  final Token token;
  const MyShipmentPage({required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Container(
            padding: const EdgeInsets.all(8.0),
            child: const Text('My Shipments')),
      ),
      body: noShipmentCreated(),
      drawer: ShipperDrawer(token: token),
    );
  }

  Widget noShipmentCreated() {
    return Container(
      child: Center(
        child: Text('No shipment created'),
      ),
    );
  }
}
