import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_app/src/pages/location_controller.dart';
import 'package:provider/provider.dart';

class LocationPage extends StatelessWidget {
  final _controller = LocationController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocationController>(
      create: (_) => LocationController(),
      child: Scaffold(
        appBar: AppBar(),
        body: Consumer<LocationController>(
            builder: (ctx, controller, __) => GoogleMap(
                onMapCreated: _controller.onMapCreated,
                markers: controller.markers,
                initialCameraPosition: controller.initialCameraPosition,
                myLocationButtonEnabled: false,
                onTap: controller.Ontap)),
      ),
    );
  }
}
