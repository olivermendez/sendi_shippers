import 'package:flutter/material.dart';
import 'package:my_app/models/bodytypes.dart';
import 'package:my_app/models/token.dart';
import 'package:my_app/src/widgets/export_widgets.dart';

import 'vehicleform.dart';

class MovingCarsFormPage extends StatefulWidget {
  final Bodytype bodySeleted;
  final Token token;
  final String image;
  const MovingCarsFormPage(
      {required this.token,
      required this.bodySeleted,
      required this.image,
      Key? key})
      : super(key: key);

  @override
  State<MovingCarsFormPage> createState() => _MovingCarsFormPage();
}

class _MovingCarsFormPage extends State<MovingCarsFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarForCategory(
        categoryName: " Moving: " + widget.bodySeleted.value,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: widget.bodySeleted.details.length,
          itemBuilder: (context, index) {
            final opt = widget.bodySeleted.details[index];

            return selectedBodyType(
                opt, widget.image, widget.token, context, widget.bodySeleted);
          },
        ),
      ),
    );
  }
}

Widget selectedBodyType(Detail opt, String image, Token token,
    BuildContext context, Bodytype bodytypeSeleted) {
  return Column(
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
                image: AssetImage("assets/bodytypes/$image"),
              )),
        ),
      ]),
      const Divider(),
      VehicleInitialForm(
        token: token,
        image: image,
        dimension: opt.dimensions,
        weight: opt.weight,
        bodytypeSeleted: bodytypeSeleted,
      )
    ],
  );
}
