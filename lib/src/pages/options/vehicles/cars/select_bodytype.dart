import 'package:flutter/material.dart';
import 'package:my_app/models/bodytypes.dart';
import 'package:my_app/models/token.dart';
import 'package:my_app/src/services/data_services.dart';

import 'moving_cars_form.dart';

class CarsSelectBodyTypePage extends StatelessWidget {
  final Token token;
  CarsSelectBodyTypePage({required this.token, Key? key}) : super(key: key);

  final _dataServices = DataServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select your vehicle type",
          style: TextStyle(fontSize: 17),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: FutureBuilder(
            future: _dataServices.getVehicleBodytype(),
            builder: (context, AsyncSnapshot<BodyTypeResponse?> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return DisplayOptions(
                    types: snapshot.data!.options.bodytypes, token: token);
              }
            },
          ),
        ),
      ),
    );
  }
}

class DisplayOptions extends StatelessWidget {
  final Token token;
  final List<Bodytype> types;
  const DisplayOptions({Key? key, required this.types, required this.token})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: types.length,
        itemBuilder: (context, index) {
          final opt = types[index];
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
                          builder: (context) => MovingCarsFormPage(
                                token: token,
                                bodySeleted: types[index],
                                image: opt.image,
                              )));
                }),
          );
        });
  }
}
