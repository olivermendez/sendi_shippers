import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';

import 'package:my_app/src/widgets/appbar/custom_appbar_category.dart';

class ExampleLocation extends StatefulWidget {
  const ExampleLocation({Key? key}) : super(key: key);

  @override
  _ExampleLocationState createState() => _ExampleLocationState();
}

class _ExampleLocationState extends State<ExampleLocation> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final origin = TextEditingController();
  final destination = TextEditingController();

  DetailsResult? startPosition;
  DetailsResult? endPosition;

  late FocusNode? startFocusNode;
  late FocusNode? endFocusNode;

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    String apiKey = 'AIzaSyCF_VxqoAxjJ7J_nAhQIVHJsvamFOQG7xg';
    googlePlace = GooglePlace(apiKey);

    startFocusNode = FocusNode();
    endFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    startFocusNode!.dispose();
    endFocusNode!.dispose();
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
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "You will move: ",
              style: TextStyle(fontWeight: FontWeight.bold),
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
                        focusNode: startFocusNode,
                        onChanged: (value) {
                          if (_debounce?.isActive ?? false) _debounce!.cancel();
                          _debounce =
                              Timer(const Duration(microseconds: 1000), () {
                            if (value.isNotEmpty) {
                              autoCompleteSearch(value);
                            } else {
                              predictions = [];
                            }
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
                        focusNode: endFocusNode,
                        onChanged: (value) {
                          if (_debounce?.isActive ?? false) _debounce!.cancel();
                          _debounce =
                              Timer(const Duration(microseconds: 1000), () {
                            if (value.isNotEmpty) {
                              autoCompleteSearch(value);
                            } else {
                              setState(() {
                                predictions = [];
                              });
                            }
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
                            onPressed: () {}, child: const Text("Continue")),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: predictions.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                child: Icon(
                                  Icons.pin_drop,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                predictions[index].description.toString(),
                              ),
                              onTap: () async {
                                final placeId = predictions[index].placeId!;
                                final details =
                                    await googlePlace.details.get(placeId);
                                if (details != null &&
                                    details.result != null &&
                                    mounted) {
                                  if (startFocusNode!.hasFocus) {
                                    setState(() {
                                      startPosition = details.result;
                                      origin.text = details.result!.name!;
                                      predictions = [];
                                    });
                                  } else {
                                    setState(() {
                                      endPosition = details.result;
                                      destination.text = details.result!.name!;
                                      predictions = [];
                                    });
                                  }

                                  if (startPosition != null &&
                                      endPosition != null) {
                                    print('navigate');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MapScreen(),
                                      ),
                                    );
                                  }
                                }
                              },
                            );
                          })
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("mapa"),
      ),
    );
  }
}
