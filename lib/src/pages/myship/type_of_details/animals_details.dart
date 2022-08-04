import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/models/household_details/household_detail_response.dart';
import 'package:my_app/models/listing/listing.dart';
import 'package:my_app/models/token.dart';

import 'package:http/http.dart' as http;
import 'package:my_app/models/vehicles_details/get_vehicles_details.dart';

import 'package:intl/intl.dart';

import '../../../../models/locations/locations_models.dart';
import '../../../services/data_services.dart';

class AnimalsDetails extends StatefulWidget {
  final Token token;
  final Listing listing;
  const AnimalsDetails({
    Key? key,
    required this.listing,
    required this.token,
  }) : super(key: key);

  @override
  _AnimalsDetailsState createState() => _AnimalsDetailsState();
}

class _AnimalsDetailsState extends State<AnimalsDetails> {
  @override
  Widget build(BuildContext context) {
    //final Listing listing =
    //   ModalRoute.of(context)!.settings.arguments as Listing;

    Widget getVehiclesDetails() {
      final _dataServices = DataServices();

      return FutureBuilder(
        future: _dataServices.getFurnitureDetails(widget.listing.id),
        builder: (context, AsyncSnapshot<GetFurnitureDetails?> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('No listing delivered'));
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Listing Details",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Height: " + snapshot.data!.height.toString()),
                Text("Width: " + snapshot.data!.width.toString()),
                Text("Weight: " + snapshot.data!.weight.toString()),
              ],
            );
          }
        },
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(widget.listing),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10),
                child: Text(
                  widget.listing.title,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10),
                child: ListingDetails(
                  listing: widget.listing,
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: routesInformation(widget.listing.id.toString()),
              ),
              ButtonActionOnListing(
                  listing: widget.listing, token: widget.token)
            ]),
          )
        ],
      ),
    );
  }
}

Widget routesInformation(String id) {
  final _dataServices = DataServices();

  return FutureBuilder(
    future: _dataServices.getSingleLocation(id),
    builder: (context, AsyncSnapshot<LocationResponse?> snapshot) {
      if (!snapshot.hasData) {
        return const Center(child: Text('No information'));
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Origin",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                      Text(
                        snapshot.data!.data[0].addressFrom,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Destination",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                      Text(
                        snapshot.data!.data[0].addressTo,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.white,
              height: 50,
            ),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    "Deliver Cost",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Expanded(
                    child: Text(
                  NumberFormat.currency()
                      .format(snapshot.data!.data[0].price)
                      .toString(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ))
              ],
            ),
          ],
        );
      }
    },
  );
}

class _CustomAppBar extends StatelessWidget {
  final Listing listing;

  const _CustomAppBar(this.listing);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color.fromRGBO(3, 9, 23, 1),
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(0),
        centerTitle: true,
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(listing.photo),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class ListingDetails extends StatelessWidget {
  final Listing listing;
  const ListingDetails({required this.listing, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final _dataServices = DataServices();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Date Created: " + listing.createdAt.toString(),
          //style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Text(
          "Quantity: " + listing.quantity,
          //style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const Divider(),
        Row(
          children: [
            Expanded(
                child: Text(
              "Type: " + listing.subcomodity,
            )),
            Expanded(
              child: Text(
                "Status: " + listing.status,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        const Divider(
          color: Colors.black12,
        ),
      ],
    );
  }
}

class ButtonActionOnListing extends StatelessWidget {
  final Token token;
  final Listing listing;
  const ButtonActionOnListing(
      {required this.listing, required this.token, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ButtonTheme(
        minWidth: double.infinity,
        child: MaterialButton(
          color: Colors.red[900],
          onPressed: () {
            deleteListing(context);
          },
          child: const Text(
            'Delete listing',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Future<void> deleteListing(context) async {
    var url = Uri.parse('${Constants.apiUrl}listings/${listing.id}');

    var response = await http.delete(
      url,
      headers: {
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': 'Bearer ${token.token}'
      },
    );

    Navigator.pop(context);

    /*

    Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false,
        arguments: token);
    var body = response.body;
    var decodedJson = jsonDecode(body);

    print(decodedJson['msg']);

    */
  }
}
