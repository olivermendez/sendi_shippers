import 'package:flutter/material.dart';

class VehiclePageCommodity extends StatelessWidget {
  const VehiclePageCommodity({Key? key, String? label}) : super(key: key);

  static const String routeName = '/vehicles-comodity';
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const VehiclePageCommodity(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle'),
      ),
    );
  }
}
