import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/src/pages/listing_detail.dart';

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
        backgroundColor: Colors.black87,
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
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          NewMoveForm(
            listing: widget.seleted,
          ),
        ],
      ),
    );
  }
}

class NewCarMoveForm extends StatelessWidget {
  const NewCarMoveForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text("cards"),
      ),
    );
  }
}

class NewMoveForm extends StatefulWidget {
  final String listing;
  NewMoveForm({required this.listing, Key? key}) : super(key: key);

  @override
  _NewMoveFormState createState() => _NewMoveFormState();
}

class _NewMoveFormState extends State<NewMoveForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var dimensions = jsonDecode(widget.listing);
    var length = dimensions['data']['length'].toString();
    var width = dimensions['data']['width'].toString();
    var height = dimensions['data']['height'].toString();
    var weight = dimensions['data']['weight'].toString();

    return Padding(
      padding: const EdgeInsets.all(20.0),
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
                    //icon: Icon(
                    //Icons.location_on,
                    //size: 30,
                    //)
                  ),
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
                    /* icon: Icon(
                        Icons.where_to_vote,
                        size: 30,
                      ) */
                  ),
                  keyboardType: TextInputType.streetAddress,
                  autocorrect: false,
                ),
                const Divider(
                  height: 40,
                ),
                const Text("When do you need your shitment deliver?",
                    style: TextStyle(fontSize: 17)),
                TextFormField(
                  decoration: const InputDecoration(
                    //labelText: 'Delivery location',
                    filled: true,
                    isDense: true,
                    hintText: 'M/D/YYYY',
                    /*  icon: Icon(
                        Icons.schedule,
                        size: 30,
                      ) */
                  ),
                  keyboardType: TextInputType.datetime,
                  autocorrect: false,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListindDetailsPage(
                                      listing: widget.listing,
                                    )));
                      },
                      child: const Text("Continue")),
                )
              ],
            ),
          )),
    );
  }
}
