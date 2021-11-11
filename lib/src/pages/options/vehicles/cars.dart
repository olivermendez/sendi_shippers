import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:my_app/config/constant.dart';
import 'package:my_app/models/bodytypes.dart';
import 'package:my_app/models/token.dart';
import 'package:my_app/src/pages/options/vehicles/bodytypes.dart';

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
      appBar: AppBar(
        title: const Text(
          "Select your body Type ",
          style: TextStyle(fontSize: 17),
        ),
        backgroundColor: Colors.black87,
        centerTitle: false,
      ),
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
