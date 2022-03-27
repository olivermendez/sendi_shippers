import 'package:flutter/material.dart';
import 'package:my_app/models/listing/listing.dart';
import 'package:my_app/models/token.dart';

class CarsLocations extends StatefulWidget {
  final Listing listingCreated;
  final Token token;
  const CarsLocations(
      {required this.listingCreated, required this.token, Key? key})
      : super(key: key);

  @override
  _CarsLocationsState createState() => _CarsLocationsState();
}

class _CarsLocationsState extends State<CarsLocations> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Locations"),
        centerTitle: false,
        backgroundColor: Colors.black87,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "You will move: " + widget.listingCreated.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: _key,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Pick up location',
                          filled: true,
                          isDense: true,
                          //icon: Icon(
                          //Icons.location_on,
                          //size: 30,
                          //)
                        ),
                        keyboardType: TextInputType.streetAddress,
                        autocorrect: false,
                      ),
                      const Divider(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Delivery location',
                          filled: true,
                          isDense: true,
                          /* icon: Icon(
                        Icons.where_to_vote,
                        size: 30,
                      ) */
                        ),
                        keyboardType: TextInputType.streetAddress,
                        autocorrect: false,
                      ),
                      const Divider(
                        height: 20,
                      ),
                      const Text("When do you need your shitment deliver?",
                          style: TextStyle(fontSize: 17)),
                      TextFormField(
                        decoration: const InputDecoration(
                          //labelText: 'Delivery location',
                          filled: true,
                          isDense: true,
                          hintText: 'M/D/YYYY',
                        ),
                        keyboardType: TextInputType.datetime,
                        autocorrect: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'home', (route) => false,
                                  arguments: widget.token);
                            },
                            child: const Text("Continue")),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}