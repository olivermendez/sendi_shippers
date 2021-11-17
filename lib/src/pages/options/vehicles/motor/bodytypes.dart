import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:my_app/config/constant.dart';
import 'package:my_app/models/motorbodytypes.dart';
import 'package:my_app/models/token.dart';

class MotorcyclesBodyTypes extends StatelessWidget {
  final Token token;
  const MotorcyclesBodyTypes({required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<MotorBodyTypesResponse?> getBodyType() async {
      var url = Uri.parse('${Constants.apiUrl}motor/bodytypes');

      var response = await http.get(
        url,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
      );
      final optionsResponse = MotorBodyTypesResponse.fromRawJson(response.body);
      return optionsResponse;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Motorcycles Body Type ",
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
            builder:
                (context, AsyncSnapshot<MotorBodyTypesResponse?> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return DisplayBodyTypeOptions(
                    snapshot.data!.options.bodytypesmotor, token);
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
  final List<Bodytypesmotor> bodytypesOptions;

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
                subtitle: Text(opt.details.weight),
                leading: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 64,
                    minHeight: 64,
                    maxWidth: 64,
                    maxHeight: 64,
                  ),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/loading.gif'),
                    image: AssetImage("assets/motorbodytypes/${opt.image}"),
                  ),
                ),
                onTap: () {}),
          );
        });
  }
}
