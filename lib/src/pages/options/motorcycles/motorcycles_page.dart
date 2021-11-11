import 'package:flutter/material.dart';
import 'package:my_app/models/commodities.dart';

class MotorcyclesPageForm extends StatefulWidget {
  final Commodity seleted;
  final String item;
  const MotorcyclesPageForm(
      {required this.seleted, required this.item, Key? key, String? label})
      : super(key: key);

  static String routeName = 'vehicles';

  @override
  State<MotorcyclesPageForm> createState() => _MotorcyclesPageForm();
}

class _MotorcyclesPageForm extends State<MotorcyclesPageForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Moving: " + widget.item,
          style: TextStyle(fontSize: 17),
        ),
        backgroundColor: Colors.black87,
        centerTitle: false,
      ),
      body: addDynamic(widget.item),
    );
  }
}

addDynamic(String item) {
  if (item == 'Motorcycles & Mopeds') {
    return const MotorcyclesAndMopedsPage();
  } else if (item == 'All Terrain Vehicles') {
    return const AllTerrainVehiclesPage();
  } else if (item == 'Go Carts & Dune Buggies') {
    return const GoCartsPage();
  } else if (item == 'Snowmobiles') {
    return const SnowmobilesPage();
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

class MotorcyclesAndMopedsPage extends StatelessWidget {
  const MotorcyclesAndMopedsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("MotorcyclesAndMopedsPage to List"),
      ),
    );
  }
}

class AllTerrainVehiclesPage extends StatelessWidget {
  const AllTerrainVehiclesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("AllTerrainVehiclesPage to List"),
      ),
    );
  }
}

class GoCartsPage extends StatelessWidget {
  const GoCartsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("GoCartsPage to List"),
      ),
    );
  }
}

class SnowmobilesPage extends StatelessWidget {
  const SnowmobilesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("SnowmobilesPage to List"),
      ),
    );
  }
}
