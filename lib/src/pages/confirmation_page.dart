import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    String date = "";

    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation Page'),
        backgroundColor: Colors.black87,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Your Shipment'),
            Text('CHAIR',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Total Weight: 23kg'),
            Divider(height: 30),
            Text('Pickup & delivery'),
            Divider(height: 10, color: Colors.white),
            RichText(
              text: TextSpan(
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
            Divider(height: 10, color: Colors.white),
            RichText(
              text: TextSpan(
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
            Divider(height: 30),
            Text(
              'Shipping Dates',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Divider(height: 10, color: Colors.white),
            Text('Pick up Date Range'),
            Text(
                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
            Divider(height: 10, color: Colors.white),
            Text('Delivery Date Range'),
            Text(
                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
            Divider(height: 30, color: Colors.white),
            ElevatedButton(
                onPressed: () {}, child: const Text("Create Listing")),
          ],
        ),
      ),
    );
  }
}
