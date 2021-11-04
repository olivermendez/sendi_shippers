import 'package:flutter/material.dart';
import 'package:my_app/models/commodities.dart';

class BoastPageForm extends StatelessWidget {
  final Commodity seleted;
  final String item;
  const BoastPageForm(
      {required this.seleted, required this.item, Key? key, String? label})
      : super(key: key);

  //static String routeName = 'vehicles';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Moving: " + item,
          style: TextStyle(fontSize: 17),
        ),
        backgroundColor: Colors.black87,
        centerTitle: false,
      ),
      body: addDynamic(item),
    );
  }
}

addDynamic(String item) {
  if (item == 'Power Boats') {
    return const PowerBoastPage();
  } else if (item == 'Sail Boats') {
    return const SailBoastPage();
  } else if (item == 'Personal Watercraft') {
    return const PersonalWatercraftPage();
  } else if (item == 'Boat Parts') {
    return const BoastPartsPage();
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

class PowerBoastPage extends StatelessWidget {
  const PowerBoastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SailBoastPage extends StatelessWidget {
  const SailBoastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BoastPartsPage extends StatelessWidget {
  const BoastPartsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class PersonalWatercraftPage extends StatelessWidget {
  const PersonalWatercraftPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
