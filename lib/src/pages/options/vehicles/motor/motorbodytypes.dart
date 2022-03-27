import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:my_app/models/motorbodytypes.dart';
import 'package:my_app/models/token.dart';
import 'package:my_app/src/pages/options/vehicles/motor/send_motorcycles.dart';
import 'package:my_app/src/services/data_services.dart';

class MotorcyclesBodyTypes extends StatelessWidget {
  final Token token;
  const MotorcyclesBodyTypes({required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _dataServices = DataServices();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Motorcycles Body Type",
          style: TextStyle(fontSize: 17),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: FutureBuilder(
            future: _dataServices.getMotorBodytypes(),
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

  // ignore: use_key_in_widget_constructors
  const DisplayBodyTypeOptions(this.bodytypesOptions, this.token);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5, crossAxisSpacing: 5, crossAxisCount: 3),
      itemBuilder: (context, index) {
        final opt = bodytypesOptions[index];
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SendMotorcyclesPage(
                          token: token,
                          bodySeleted: bodytypesOptions[index],
                        )));
          },
          child: Center(
            child: Card(
              child: Container(
                height: 110,
                width: 110,
                color: Colors.white38,
                child: Column(
                  children: [
                    ConstrainedBox(
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
                    Text(opt.value),
                    Text(
                      opt.details.weight,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: bodytypesOptions.length,
    );
  }
}
