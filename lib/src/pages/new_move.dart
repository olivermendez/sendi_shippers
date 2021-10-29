import 'package:flutter/material.dart';

class NewMovePage extends StatefulWidget {
  final String seleted;
  NewMovePage({required this.seleted, Key? key}) : super(key: key);

  @override
  _NewMovePageState createState() => _NewMovePageState();
}

class _NewMovePageState extends State<NewMovePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Move"),
        centerTitle: false,
        backgroundColor: const Color.fromRGBO(37, 59, 128, 5),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: Text(
              "You will move: " + widget.seleted,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          NewMoveForm(),
        ],
      ),
    );
  }
}

class NewMoveForm extends StatefulWidget {
  NewMoveForm({Key? key}) : super(key: key);

  @override
  _NewMoveFormState createState() => _NewMoveFormState();
}

class _NewMoveFormState extends State<NewMoveForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Pick up location',
                      filled: true,
                      isDense: true,
                      icon: Icon(
                        Icons.location_on,
                        size: 30,
                      )),
                  //controller: _username,
                  keyboardType: TextInputType.streetAddress,
                  autocorrect: false,
                ),
                const Divider(
                  height: 30,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Delivery location',
                      filled: true,
                      isDense: true,
                      icon: Icon(
                        Icons.where_to_vote,
                        size: 30,
                      )),
                  //controller: _username,
                  keyboardType: TextInputType.streetAddress,
                  autocorrect: false,
                ),
                const Divider(
                  height: 40,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 45, bottom: 10),
                  child: Text("When do you need your shitment deliver?",
                      style: TextStyle(fontSize: 17)),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      //labelText: 'Delivery location',
                      filled: true,
                      isDense: true,
                      hintText: 'M/D/YYYY',
                      icon: Icon(
                        Icons.schedule,
                        size: 30,
                      )),
                  //controller: _username,
                  keyboardType: TextInputType.datetime,
                  autocorrect: false,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:
                      ElevatedButton(onPressed: () {}, child: Text("Continue")),
                )
              ],
            ),
          )),
    );
  }
}
