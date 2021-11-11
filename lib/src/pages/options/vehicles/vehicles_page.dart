import 'package:flutter/material.dart';
import 'package:my_app/config/constant.dart';
import 'package:my_app/models/bodytypes.dart';
import 'package:my_app/models/commodities.dart';

import 'package:http/http.dart' as http;
import 'package:my_app/models/token.dart';

import 'bodytypes.dart';

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

class TrailersPage extends StatelessWidget {
  const TrailersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
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
      child: const Center(
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
      child: const Center(
        child: Text("Airplanes Page to List"),
      ),
    );
  }
}
