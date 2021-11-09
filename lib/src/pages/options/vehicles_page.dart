import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/config/constant.dart';
import 'package:my_app/models/bodytypes.dart';
import 'package:my_app/models/commodities.dart';

import 'package:http/http.dart' as http;
import 'package:my_app/models/token.dart';
import 'package:my_app/src/pages/listing_locations.dart';

class VehiclePageForm extends StatefulWidget {
  final Token token;
  final Commodity seleted;
  final String item;
  const VehiclePageForm(
      {required this.seleted,
      required this.item,
      required this.token,
      Key? key,
      String? label})
      : super(key: key);

  static String routeName = 'vehicles';

  @override
  State<VehiclePageForm> createState() => _VehiclePageFormState();
}

class _VehiclePageFormState extends State<VehiclePageForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Select your body Type ",
          style: TextStyle(fontSize: 17),
        ),
        backgroundColor: Colors.black87,
        centerTitle: false,
      ),
      body: addDynamic(widget.item, widget.token),
    );
  }
}

addDynamic(String item, Token token) {
  if (item == 'Cars & Light Trucks') {
    return CarsAndLightTrucksPage(
      token: token,
    );
  } else if (item == 'Trailers') {
    return const TrailersPage();
  } else if (item == 'Vehicle Parts') {
    return const VehiclePartsPage();
  } else if (item == 'Airplanes') {
    return const AirplanesPage();
  } else {
    return Container(
      color: Colors.red,
      child: const Center(
        child: Text(
          "Listing no defined",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}

class CarsAndLightTrucksPage extends StatelessWidget {
  final Token token;
  const CarsAndLightTrucksPage({required this.token, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<BodyTypeResponse?> getBodyType() async {
      var url = Uri.parse('${Constants.apiUrl}vehicle/bodytypes');

      var response = await http.get(
        url,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
      );
      final optionsResponse = BodyTypeResponse.fromRawJson(response.body);
      return optionsResponse;
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: FutureBuilder(
            future: getBodyType(),
            builder: (context, AsyncSnapshot<BodyTypeResponse?> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return DisplayBodyTypeOptions(
                    snapshot.data!.options.bodytypes, token);
              }
            },
          ),
        ),
      ),
    );
  }
}

class DisplayBodyTypeOptions extends StatelessWidget {
  final Token token;
  final List<Bodytype> bodytypesOptions;
  // ignore: use_key_in_widget_constructors
  const DisplayBodyTypeOptions(this.bodytypesOptions, this.token);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: bodytypesOptions.length,
        itemBuilder: (context, index) {
          final opt = bodytypesOptions[index];
          //final bodySeleted = bodytypesOptions[index].details;
          return Card(
            elevation: 0,
            child: ListTile(
                title: Text(opt.value),
                trailing: const Icon(Icons.arrow_right_alt),
                //subtitle: Text('hola'),
                leading: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 64,
                      minHeight: 64,
                      maxWidth: 64,
                      maxHeight: 64,
                    ),
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/loading.gif'),
                      image: AssetImage("assets/bodytypes/${opt.image}"),
                    )),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => New(
                                token: token,
                                bodySeleted: bodytypesOptions[index],
                                image: opt.image,
                              )));
                }),
          );
        });
  }
}

class New extends StatefulWidget {
  final Bodytype bodySeleted;
  final Token token;
  final String image;
  const New(
      {required this.token,
      required this.bodySeleted,
      required this.image,
      Key? key})
      : super(key: key);

  @override
  State<New> createState() => _New();
}

class _New extends State<New> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String bodytype = '';
  String dimensions = '';
  String weight = '';
  bool operable = false;
  bool convertible = false;
  bool modified = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(" Moving Car Type: " + widget.bodySeleted.value),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: widget.bodySeleted.details.length,
          itemBuilder: (context, index) {
            final opt = widget.bodySeleted.details[index];

            return Form(
              //key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(children: [
                    Expanded(
                      child: Container(
                        color: Colors.amber[30],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Average Dimensions',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                opt.dimensions,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const Text(
                                'Average Weight',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                opt.weight,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          height: 150,
                          width: 200,
                          child: FadeInImage(
                            placeholder: const AssetImage('assets/loading.gif'),
                            image:
                                AssetImage("assets/bodytypes/${widget.image}"),
                          )),
                    ),
                  ]),
                  const Divider(),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Shipment Title'),
                      helperText: 'e.g. 2015 Chevrolet Master',
                      hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                      filled: true,
                      isDense: true,
                    ),
                    onChanged: (value) {
                      // _title = value;
                    },
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                  ),
                  const Divider(
                    height: 20,
                    color: Colors.white,
                  ),
                  TextFormField(
                    maxLines: 3,
                    decoration: const InputDecoration(
                      label: Text('Add description'),
                      //hintText: 'What type of furniture? i.e couch, chair',
                      hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                      filled: true,
                      isDense: true,
                    ),
                    onChanged: (value) {
                      //_description = value;
                    },
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                  ),
                  const Divider(
                    height: 20,
                    color: Colors.white,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        //createListing(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewMovePage(
                                      seleted: 'hola',
                                    )));
                      },
                      child: const Text("Continue")),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void createListing(BuildContext context) async {
    Map<String, dynamic> request = {
      //"title": _title,
      //"description": _description,
      //"commodity": _type
    };

    var url = Uri.parse('${Constants.apiUrl}listings');

    var response = await http.post(
      url,
      body: jsonEncode(request),
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer ${widget.token.token}'
      },
    );
    var body = response.body;
    var decodedJson = jsonDecode(body);
    //var listing = CreateListingResponse.fromJson(decodedJson);

    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => DimesionsDetails()));
  }
}

class TrailersPage extends StatelessWidget {
  const TrailersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Trailers Page to List"),
      ),
    );
  }
}

class VehiclePartsPage extends StatelessWidget {
  const VehiclePartsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("VehicleParts Page to List"),
      ),
    );
  }
}

class AirplanesPage extends StatelessWidget {
  const AirplanesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Airplanes Page to List"),
      ),
    );
  }
}
