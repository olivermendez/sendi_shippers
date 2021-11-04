import 'package:flutter/material.dart';
import 'package:my_app/models/commodities.dart';

class VehiclePageForm extends StatefulWidget {
  final Commodity seleted;
  final String item;
  const VehiclePageForm(
      {required this.seleted, required this.item, Key? key, String? label})
      : super(key: key);

  static String routeName = 'vehicles';

  @override
  State<VehiclePageForm> createState() => _VehiclePageFormState();
}

class _VehiclePageFormState extends State<VehiclePageForm> {
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
  if (item == 'Cars & Light Trucks') {
    return const CarsAndLightTrucksPage();
  } else if (item == 'Trailers') {
    return const TrailersPage();
  } else if (item == 'Vehicle Parts') {
    return const VehiclePartsPage();
  } else if (item == 'Airplanes') {
    return const AirplanesPage();
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

class CarsAndLightTrucksPage extends StatelessWidget {
  const CarsAndLightTrucksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("CarsAndLightTrucks Page to List"),
      ),
    );
  }
}

class TrailersPage extends StatelessWidget {
  const TrailersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Trailers Page to List"),
      ),
    );
  }
}

class VehiclePartsPage extends StatelessWidget {
  const VehiclePartsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("VehicleParts Page to List"),
      ),
    );
  }
}

class AirplanesPage extends StatelessWidget {
  const AirplanesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Airplanes Page to List"),
      ),
    );
  }
}
