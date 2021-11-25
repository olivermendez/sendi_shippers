import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_app/models/token.dart';

const double _minHeight = 200;

class SecondFormLocationAnimals extends StatefulWidget {
  //final Listing listingCreated;
  final Token token;
  const SecondFormLocationAnimals({required this.token, Key? key})
      : super(key: key);

  @override
  _SecondFormLocationAnimalsState createState() =>
      _SecondFormLocationAnimalsState();
}

class _SecondFormLocationAnimalsState extends State<SecondFormLocationAnimals> {
  //final _key = GlobalKey<FormState>();
  LatLng startingLocation = LatLng(-2.1611081, -79.9022226);
  GoogleMapController? _mapController;

  void onCreated(GoogleMapController mapController) {
    _mapController = mapController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: _minHeight),
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: startingLocation,
                zoom: 15,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              onMapCreated: onCreated,
            ),
          ),
          Positioned(
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              onPressed: () {},
              child: Icon(
                Icons.gps_fixed,
                color: Colors.black,
              ),
            ),
            bottom: MediaQuery.of(context).size.height,
          ),
          Positioned(
              top: 60,
              left: 20,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                ),
              )),
          Positioned(
            child: _draggable(),
            height: _minHeight,
            bottom: 0,
            right: 0,
            left: 0,
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(height: 180, child: _appBar()),
          ),
        ],
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        'Enter destination',
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {},
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 21.5),
          child: Column(
            children: [
              _Input(
                  iconData: Icons.gps_fixed,
                  hintText: 'Jose Santiago Castillo 28',
                  color: Colors.green),
              SizedBox(
                height: 9,
              ),
              Row(
                children: [
                  _Input(
                    iconData: Icons.place_sharp,
                    color: Colors.indigo,
                    hintText: 'Ingresar destino',
                  ),
                  Icon(
                    Icons.add,
                    size: 25,
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _draggable() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(0, -1),
              blurRadius: 3,
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          )),
      child: Column(children: [
        Container(
          margin: EdgeInsets.all(10.0),
          width: 35,
          color: Colors.grey[300],
          height: 3.5,
        ),
        _searchButton(),
        LocationListTile(head: 'Enter Home Location', icon: Icons.home),
        LocationListTile(head: 'Enter Work Location', icon: Icons.work),
      ]),
    );
  }

  Widget _searchButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width / 1.1,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0), color: Colors.grey[200]),
        child: Text(
          'Where to?',
          style: TextStyle(fontSize: 17.5, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class LocationListTile extends StatelessWidget {
  final String head;
  final IconData icon;
  const LocationListTile({Key? key, required this.head, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 37.0, top: 26.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey,
            size: 25,
          ),
          SizedBox(
            width: 22,
          ),
          Text(
            head,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

// ignore: unused_element
class _Input extends StatelessWidget {
  final IconData? iconData;
  final void Function(String)? onChanged;
  final String? hintText;
  final VoidCallback? ontap;
  final bool? enabled;
  final Color? color;
  const _Input({
    Key? key,
    this.iconData,
    this.onChanged,
    this.hintText,
    this.ontap,
    this.enabled = false,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          size: 19,
          color: color,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width / 1.4,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.grey[200],
              ),
              child: TextField(
                  onTap: ontap,
                  enabled: enabled,
                  onChanged: onChanged,
                  decoration: InputDecoration.collapsed(
                      hintText: hintText,
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      )))),
        )
      ],
    );
  }
}
