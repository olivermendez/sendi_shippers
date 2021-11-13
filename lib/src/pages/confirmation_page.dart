import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    const String date = "";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation Page'),
        backgroundColor: Colors.black87,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Your Shipment'),
            const Text('CHAIR',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('Total Weight: 23kg'),
            const Divider(height: 30),
            const Text('Pickup & delivery'),
            const Divider(height: 10, color: Colors.white),
            RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black),
                children: [
                  WidgetSpan(
                    child: Icon(Icons.north_east, size: 20),
                  ),
                  TextSpan(
                    text: "New York, NY 10001",
                  ),
                ],
              ),
            ),
            const Divider(height: 10, color: Colors.white),
            RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.black),
                children: [
                  WidgetSpan(
                    child: Icon(Icons.south_east, size: 20),
                  ),
                  TextSpan(
                    text: "New York, NY 10001",
                  ),
                ],
              ),
            ),
            const Divider(height: 30),
            const Text(
              'Shipping Dates',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Divider(height: 10, color: Colors.white),
            const Text('Pick up Date Range'),
            Text(
                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
            const Divider(height: 10, color: Colors.white),
            const Text('Delivery Date Range'),
            Text(
                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
            const Divider(height: 30, color: Colors.white),
            ElevatedButton(
                onPressed: () {}, child: const Text("Create Listing")),
          ],
        ),
      ),
    );
  }
}
