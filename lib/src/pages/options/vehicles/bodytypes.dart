import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:my_app/config/constant.dart';
import 'package:my_app/models/bodytypes.dart';
import 'package:my_app/models/token.dart';

import 'cars/cars.dart';

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
          "Select your Body Type ",
          style: TextStyle(fontSize: 17),
        ),
        centerTitle: false,
        elevation: 0,
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
          return Card(
            elevation: 0,
            child: ListTile(
                title: Text(opt.value),
                trailing: const Text(
                  'SELECT',
                  style: TextStyle(color: Colors.blue, fontSize: 10),
                ),
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
                          builder: (context) => SendVehicle(
                                token: token,
                                bodySeleted: bodytypesOptions[index],
                                image: opt.image,
                              )));
                }),
          );
        });
  }
}
