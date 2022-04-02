import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:my_app/src/pages/location_controller.dart';

import 'package:my_app/src/widgets/appbar/custom_appbar_category.dart';

import '../../../models/listing/listing.dart';
import '../../../models/token.dart';
import '../../services/data_services.dart';
import '../confirmation_page.dart';

import 'package:http/http.dart' as http;

class LocationsPage extends StatefulWidget {
  final Listing listingCreated;
  final Token token;

  const LocationsPage(
      {Key? key, required this.listingCreated, required this.token})
      : super(key: key);

  @override
  _LocationsPageState createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
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
                                          listing: widget.listingCreated,
                                          startPosition: startPosition,
                                          endPosition: endPosition,
                                          token: widget.token,
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

class MapScreen extends StatefulWidget {
  final Listing listing;
  final Token token;
  final DetailsResult? startPosition;
  final DetailsResult? endPosition;

  const MapScreen(
      {Key? key,
      required this.listing,
      this.startPosition,
      this.endPosition,
      required this.token})
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

  double totalDistance = 0;
  double distance = 0.0;

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 5,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyBTZ87zym2DZTOPcmjKBpTyWS3iggwsRPk',
      PointLatLng(widget.startPosition!.geometry!.location!.lat!,
          widget.startPosition!.geometry!.location!.lng!),
      PointLatLng(widget.endPosition!.geometry!.location!.lat!,
          widget.endPosition!.geometry!.location!.lng!),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print(result.errorMessage);
    }

    for (var i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += calculateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }
    print(totalDistance);

    setState(() {
      distance = totalDistance;
      print("Distance: " + distance.toString());
      print("Total Distance: " + totalDistance.toString());
    });

    _addPolyLine(polylineCoordinates);
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> _markers = {
      Marker(
          markerId: const MarkerId('start'),
          position: LatLng(
            widget.startPosition!.geometry!.location!.lat!,
            widget.startPosition!.geometry!.location!.lng!,
          )),
      Marker(
          markerId: const MarkerId('end'),
          position: LatLng(
            widget.endPosition!.geometry!.location!.lat!,
            widget.endPosition!.geometry!.location!.lng!,
          ))
    };

    final _controller = LocationController();

    var regular = 10.0 * (totalDistance);
    var plus = 20.0 * (totalDistance);
    var premiun = 30.0 * (totalDistance);

    print(totalDistance);

    List cars = [
      {
        'id': 0,
        'name': 'Select a Ride',
        'price': 0.0,
        'deliver': 'Deliver time: 5 - 10 dias'
      },
      {
        'id': 1,
        'name': 'Regular',
        'price': regular,
        'deliver': 'Deliver time: 5-3 dias'
      },
      {
        'id': 2,
        'name': 'Plus',
        'price': plus,
        'deliver': 'Deliver time: 3-1 dias'
      },
      {
        'id': 3,
        'name': 'Premiun',
        'price': premiun,
        'deliver': 'Deliver time: 24 hrs'
      },
    ];

    String? _addressFrom = widget.startPosition!.formattedAddress.toString();
    String? _addressTo = widget.endPosition!.formattedAddress.toString();
    int _price = regular.toInt();

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: const CustomAppBarForCategory(
        categoryName: "Costo del envio",
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0,
        onPressed: () {
          print(widget.startPosition!.formattedAddress.toString());
          print(widget.endPosition!.formattedAddress.toString());

          CreateLocationToDB(_addressFrom, _addressTo, _price);

          /*
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ConfirmationPage(
                        token: widget.token,
                      )));

                      */
        },
        label: const Text('Create Listing'),
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
                              car['price'].toStringAsFixed(2),
                            ),
                            subtitle: Text(car['deliver']),
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

  Future<void> CreateLocationToDB(
    final String _addressFrom,
    final String _addressTo,
    final int _price,
  ) async {
    Map<String, dynamic> request = {
      "addressFrom": _addressFrom,
      "addressTo": _addressTo,
      "price": _price,
    };

    var url =
        Uri.parse('${Constants.apiUrl}listings/${widget.listing.id}/location');

    var response = await http.post(
      url,
      body: jsonEncode(request),
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer ${widget.token}'
      },
    );
    var body = response.body;
    var decodedJson = jsonDecode(body);
    //var result = ListingResponse.fromJson(decodedJson);
    //print(result.success);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConfirmationPage(
                  token: widget.token,
                )));
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
