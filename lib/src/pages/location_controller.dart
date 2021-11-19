import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_app/src/pages/utils/map_style.dart';

class LocationController extends ChangeNotifier {
  Map<MarkerId, Marker> _markers = {};

  Set<Marker> get markers => _markers.values.toSet();
  final _markerController = StreamController<String>.broadcast();
  Stream<String> get onMarkerTap => _markerController.stream;

  final initialCameraPosition =
      const CameraPosition(target: LatLng(18.438325, -69.997055), zoom: 15);

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(mapStyle);
  }

  void Ontap(LatLng position) {
    final id = _markers.length.toString();
    final markerId = MarkerId(id);
    final marker = Marker(
        markerId: markerId,
        position: position,
        draggable: true,
        onTap: () {
          _markerController.sink.add(id);
        });

    _markers[markerId] = marker;
    notifyListeners();
  }
}
