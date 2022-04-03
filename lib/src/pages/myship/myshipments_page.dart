import 'package:flutter/material.dart';
import 'package:my_app/models/listing/dynamiclisting.dart';
import 'package:my_app/models/listing/listing.dart';
import 'package:my_app/models/locations/locations_models.dart';
import 'package:my_app/models/token.dart';

import 'package:my_app/src/services/data_services.dart';

import 'detail_page_listing_created.dart';

class MyShipmentPage extends StatelessWidget {
  final Token token;

  const MyShipmentPage({required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Active',
                ),
                Tab(
                  text: 'Booked',
                ),
                Tab(
                  text: 'Delivered',
                )
              ],
            ),
            title: Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text('My Shipments')),
          ),
          body: TabBarView(
            children: [
              activedShipment(),
              bookedShipment(),
              deliveredShipment(),
            ],
          ),
        ),
      );

  Widget activedShipment() {
    final _dataServices = DataServices();

    return FutureBuilder(
      future: _dataServices.getActiveListingByUser(token),
      builder: (context, AsyncSnapshot<DynamicListingResponse?> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data!.listing.isEmpty) {
          return noListingFound();
        } else {
          return DisplayOptions(snapshot.data!.listing, token);
        }
      },
    );
  }

  Widget deliveredShipment() {
    final _dataServices = DataServices();

    return FutureBuilder(
      future: _dataServices.getDeliveredListingByUserId(token),
      builder: (context, AsyncSnapshot<DynamicListingResponse?> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: Text('No listing delivered'));
        } else if (snapshot.data!.listing.isEmpty) {
          return noListingFound();
        } else {
          return DisplayOptions(snapshot.data!.listing, token);
        }
      },
    );
  }

  Widget bookedShipment() {
    final _dataServices = DataServices();

    return FutureBuilder(
      future: _dataServices.getBookedListingByUser(token),
      builder: (context, AsyncSnapshot<DynamicListingResponse?> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: Text('No listing delivered'));
        } else if (snapshot.data!.listing.isEmpty) {
          return noListingFound();
        } else {
          return DisplayOptions(snapshot.data!.listing, token);
        }
      },
    );
  }
}

Widget noListingFound() {
  return const Center(
    child: Text(
      "No listing created yet",
      style: TextStyle(color: Colors.black),
    ),
  );
}

class DisplayOptions extends StatelessWidget {
  final Token token;
  final List<Listing> listing;
  const DisplayOptions(this.listing, this.token);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listing.length,
        itemBuilder: (context, index) {
          final opt = listing[index];
          return Card(
            elevation: 1,
            child: ListTile(
                title: Text(opt.title),
                subtitle: Text(opt.comodity),
                trailing: Text(opt.status),
                leading: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 64,
                      minHeight: 64,
                      maxWidth: 64,
                      maxHeight: 64,
                    ),
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/loading.gif'),
                      image: NetworkImage(opt.photo),
                    )),
                onTap: () {
                  switch (opt.comodity) {
                    case 'vehicles':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailPageForVehiclesListing(
                                    listing: opt,
                                    token: token,
                                  )));
                      break;

                    case 'household':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailPageForHouseholdListing(
                                      //listing: opt,
                                      //token: token,
                                      )));
                      break;
                    default:
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Error()));
                  }
                }),
          );
        });
  }
}

class DetailPageForHouseholdListing extends StatelessWidget {
  const DetailPageForHouseholdListing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Household'),
      ),
    );
  }
}

class Error extends StatelessWidget {
  const Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('error'),
      ),
    );
  }
}
