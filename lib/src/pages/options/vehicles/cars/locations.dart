import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:my_app/models/listing/listing.dart';
import 'package:my_app/models/token.dart';
import 'package:my_app/src/widgets/appbar/custom_appbar_category.dart';

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

  final origin = TextEditingController();
  final destination = TextEditingController();

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    String apiKey = 'AIzaSyCF_VxqoAxjJ7J_nAhQIVHJsvamFOQG7xg';
    googlePlace = GooglePlace(apiKey);
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      print(result.predictions!.first.description);
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarForCategory(
        categoryName: "Locations",
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
                        onChanged: (value) {
                          if (_debounce?.isActive ?? false) _debounce!.cancel();
                          _debounce =
                              Timer(const Duration(microseconds: 1000), () {
                            if (value.isNotEmpty) {
                              autoCompleteSearch(value);
                            } else {}
                          });
                        },
                        controller: origin,
                        decoration: const InputDecoration(
                          labelText: 'Pick up location',
                          filled: true,
                          isDense: true,
                        ),
                        keyboardType: TextInputType.streetAddress,
                        autocorrect: false,
                      ),
                      const Divider(
                        height: 20,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          if (_debounce?.isActive ?? false) _debounce!.cancel();
                          _debounce =
                              Timer(const Duration(microseconds: 1000), () {
                            if (value.isNotEmpty) {
                              autoCompleteSearch(value);
                            } else {}
                          });
                        },
                        controller: destination,
                        decoration: const InputDecoration(
                          labelText: 'Delivery location',
                          filled: true,
                          isDense: true,
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
