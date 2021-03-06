import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:my_app/src/pages/location_controller.dart';

import 'package:my_app/src/widgets/appbar/custom_appbar_category.dart';

class ExampleLocation extends StatefulWidget {
  const ExampleLocation({Key? key}) : super(key: key);

  @override
  _ExampleLocationState createState() => _ExampleLocationState();
}

class _ExampleLocationState extends State<ExampleLocation> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final origin = TextEditingController();
  final destination = TextEditingController();

  DetailsResult? startPosition;
  DetailsResult? endPosition;

  late FocusNode? startFocusNode;
  late FocusNode? endFocusNode;

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    String apiKey = 'AIzaSyCF_VxqoAxjJ7J_nAhQIVHJsvamFOQG7xg';
    googlePlace = GooglePlace(apiKey);

    startFocusNode = FocusNode();
    endFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    startFocusNode!.dispose();
    endFocusNode!.dispose();
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      print(result.predictions!.first.description);
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarForCategory(
        categoryName: "Locations",
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "You will move: ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: _key,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        focusNode: startFocusNode,
                        onChanged: (value) {
                          if (_debounce?.isActive ?? false) _debounce!.cancel();
                          _debounce =
                              Timer(const Duration(microseconds: 1000), () {
                            if (value.isNotEmpty) {
                              autoCompleteSearch(value);
                            } else {
                              predictions = [];
                            }
                          });
                        },
                        controller: origin,
                        decoration: const InputDecoration(
                          labelText: 'Pick up location',
                          filled: true,
                          isDense: true,
                        ),
                        keyboardType: TextInputType.streetAddress,
                        autocorrect: false,
                      ),
                      const Divider(
                        height: 20,
                      ),
                      TextFormField(
                        focusNode: endFocusNode,
                        onChanged: (value) {
                          if (_debounce?.isActive ?? false) _debounce!.cancel();
                          _debounce =
                              Timer(const Duration(microseconds: 1000), () {
                            if (value.isNotEmpty) {
                              autoCompleteSearch(value);
                            } else {
                              setState(() {
                                predictions = [];
                              });
                            }
                          });
                        },
                        controller: destination,
                        decoration: const InputDecoration(
                          labelText: 'Delivery location',
                          filled: true,
                          isDense: true,
                        ),
                        keyboardType: TextInputType.streetAddress,
                        autocorrect: false,
                      ),
                      const Divider(
                        height: 20,
                      ),
                      const Text("When do you need your shitment deliver?",
                          style: TextStyle(fontSize: 17)),
                      TextFormField(
                        decoration: const InputDecoration(
                          filled: true,
                          isDense: true,
                          hintText: 'M/D/YYYY',
                        ),
                        keyboardType: TextInputType.datetime,
                        autocorrect: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text("Continue")),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: predictions.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const CircleAvatar(
                                child: Icon(
                                  Icons.pin_drop,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                predictions[index].description.toString(),
                              ),
                              onTap: () async {
                                final placeId = predictions[index].placeId!;
                                final details =
                                    await googlePlace.details.get(placeId);
                                if (details != null &&
                                    details.result != null &&
                                    mounted) {
                                  if (startFocusNode!.hasFocus) {
                                    setState(() {
                                      startPosition = details.result;
                                      origin.text = details.result!.name!;
                                      predictions = [];
                                    });
                                  } else {
                                    setState(() {
                                      endPosition = details.result;
                                      destination.text = details.result!.name!;
                                      predictions = [];
                                    });
                                  }

                                  if (startPosition != null &&
                                      endPosition != null) {
                                    print("aqui");
                                    print(startPosition!.formattedAddress);
                                    print(endPosition!.formattedAddress);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MapScreen(
                                          startPosition: startPosition,
                                          endPosition: endPosition,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                            );
                          })
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

List cars = [
  {'id': 0, 'name': 'Select a Ride', 'price': 0.0},
  {'id': 1, 'name': 'SendiGo', 'price': 230.0},
  {'id': 2, 'name': 'Go Sedan', 'price': 300.0},
  {'id': 3, 'name': 'SendiXL', 'price': 500.0},
  {'id': 4, 'name': 'SendiAuto', 'price': 140.0},
];

class MapScreen extends StatefulWidget {
  final DetailsResult? startPosition;
  final DetailsResult? endPosition;

  const MapScreen({Key? key, this.startPosition, this.endPosition})
      : super(key: key);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late CameraPosition _initialPosition;
  final Completer<GoogleMapController> _controller = Completer();

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  int selectedCarId = 1;
  bool backButtonVisible = true;
  @override
  void initState() {
    super.initState();
    _initialPosition = CameraPosition(
      target: LatLng(
        widget.startPosition!.geometry!.location!.lat!,
        widget.startPosition!.geometry!.location!.lng!,
      ),
      zoom: 80,
    );
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 10,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyBTZ87zym2DZTOPcmjKBpTyWS3iggwsRPk',
        PointLatLng(widget.startPosition!.geometry!.location!.lat!,
            widget.startPosition!.geometry!.location!.lng!),
        PointLatLng(widget.endPosition!.geometry!.location!.lat!,
            widget.endPosition!.geometry!.location!.lng!),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    _addPolyLine();
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> _markers = {
      Marker(
          markerId: const MarkerId('start'),
          position: LatLng(widget.startPosition!.geometry!.location!.lat!,
              widget.startPosition!.geometry!.location!.lng!)),
      Marker(
          markerId: const MarkerId('end'),
          position: LatLng(widget.endPosition!.geometry!.location!.lat!,
              widget.endPosition!.geometry!.location!.lng!))
    };

    final _controller = LocationController();

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: const CustomAppBarForCategory(
        categoryName: "Costo del envio",
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        onPressed: () {},
        label: const Text('Aceptar'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: <Widget>[
          LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
              height: constraints.maxHeight / 2,
              child: GoogleMap(
                onTap: _controller.Ontap,
                polylines: Set<Polyline>.of(polylines.values),
                initialCameraPosition: _initialPosition,
                markers: Set.from(_markers),
                onMapCreated: (GoogleMapController controller) {
                  Future.delayed(const Duration(milliseconds: 2000), () {
                    controller.animateCamera(CameraUpdate.newLatLngBounds(
                        MapUtils.boundsFromLatLngList(
                          _markers.map((loc) => loc.position).toList(),
                        ),
                        1));
                    _getPolyline();
                  });
                },
              ),
            );
          }),
          DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.5,
              maxChildSize: 1,
              snapSizes: const [0.5, 1],
              snap: true,
              builder: (BuildContext context, scrollSheetController) {
                return Container(
                    color: Colors.white,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const ClampingScrollPhysics(),
                      controller: scrollSheetController,
                      itemCount: cars.length,
                      itemBuilder: (BuildContext context, int index) {
                        final car = cars[index];
                        if (index == 0) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: const [
                                  SizedBox(
                                    width: 50,
                                    child: Divider(
                                      thickness: 5,
                                    ),
                                  ),
                                  Text('Choose a tripe or swipe up for more')
                                ],
                              ));
                        }
                        return Card(
                          margin: EdgeInsets.zero,
                          elevation: 0,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            onTap: () {
                              setState(() {
                                selectedCarId = car['id'];
                              });
                            },
                            leading: const Icon(Icons.car_rental),
                            title: Text(car['name']),
                            trailing: Text(
                              car['price'].toString(),
                            ),
                            selected: selectedCarId == car['id'],
                            selectedTileColor: Colors.grey[200],
                          ),
                        );
                      },
                    ));
              }),
        ],
      ),
    );
  }
}

class MapUtils {
  static LatLngBounds boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
        northeast: LatLng(x1! + 1, y1! + 1),
        southwest: LatLng(x0! - 1, y0! - 1));
  }
}
