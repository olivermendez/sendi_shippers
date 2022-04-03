import 'package:flutter/material.dart';
import 'package:my_app/models/motorbodytypes.dart';
import 'package:my_app/models/token.dart';
import 'motorform.dart';

class SendMotorcyclesPage extends StatelessWidget {
  final Bodytypesmotor bodySeleted;
  final Token token;
  const SendMotorcyclesPage({
    Key? key,
    required this.token,
    required this.bodySeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Moving: " + bodySeleted.value),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          itemToSendBox(bodySeleted),
          const Divider(),
          MotorcyclesForm(
            bodySeleted: bodySeleted,
            token: token,
          )
        ],
      ),
    );
  }
}

Widget itemToSendBox(Bodytypesmotor bodySeleted) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Expanded(
        child: Container(
          color: Colors.blue[50],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const Text(
                  'Average Dimensions',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  bodySeleted.details.dimensions,
                  style: const TextStyle(color: Colors.grey),
                ),
                const Text(
                  'Average Weight',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  bodySeleted.details.weight,
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
            child: FadeInImage(
              placeholder: const AssetImage('assets/loading.gif'),
              image: AssetImage("assets/motorbodytypes/${bodySeleted.image}"),
            )),
      ),
    ]),
  );
}
