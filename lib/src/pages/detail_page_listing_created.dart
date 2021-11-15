import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/config/constant.dart';
import 'package:my_app/models/listing/listing.dart';
import 'package:my_app/models/token.dart';

import 'package:http/http.dart' as http;

class DetailPageListing extends StatefulWidget {
  final Token token;
  final Listing listing;
  const DetailPageListing({
    Key? key,
    required this.listing,
    required this.token,
  }) : super(key: key);

  @override
  _DetailPageListingState createState() => _DetailPageListingState();
}

class _DetailPageListingState extends State<DetailPageListing> {
  @override
  Widget build(BuildContext context) {
    //final Listing listing =
    //   ModalRoute.of(context)!.settings.arguments as Listing;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(widget.listing),
          SliverList(
            delegate: SliverChildListDelegate([
              ListingTitle(widget.listing),
              ListingDetails(
                listing: widget.listing,
              ),
              const Divider(),
              FromToDestination(
                listing: widget.listing,
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

class ListingTitle extends StatelessWidget {
  final Listing listing;

  ListingTitle(this.listing, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        listing.title,
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
      ),
    );
  }
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
      //title: const Text(
      //  "Listing Details",
      //  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      // s),

      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(0),
        centerTitle: true,
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(listing.photo),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class PrimaryImageListing extends StatelessWidget {
  final Listing listing;
  const PrimaryImageListing({required this.listing, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: 400,
        margin: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: FadeInImage(
            placeholder: const AssetImage('assets/loading.gif'),
            image: NetworkImage(listing.photo),
            fit: BoxFit.cover,
          ),
        ));
  }
}

class ListingDetails extends StatelessWidget {
  final Listing listing;
  const ListingDetails({required this.listing, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Text(
            "Listing Expires in 6d 23 h",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 10),
          child: Text(
            "Offer ",
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(
          color: Colors.black12,
        ),
        ListTile(
            title: const Text(
              "Listing Question ?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.question_answer, color: Colors.blue),
            onTap: () {}),
        const Divider(
          color: Colors.black12,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 15.0, top: 10),
          child: Text(
            "Listing Details",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Column(
            children: [
              Text("Height: M"),
              Text("Length: M"),
              Text(
                "Weigh: Grams",
              ),
              Text(
                "Width:  M",
              ),
            ],
          ),
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

    Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false,
        arguments: token);
    var body = response.body;
    var decodedJson = jsonDecode(body);

    print(decodedJson['msg']);
  }
}

class FromToDestination extends StatelessWidget {
  final Listing listing;
  const FromToDestination({required this.listing, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ListTile(
          title: Text(
            "From: ",
          ),
          trailing: Icon(Icons.south_east, color: Colors.blue),
        ),
        ListTile(
          title: Text(
            "To ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.north_east, color: Colors.blue),
        )
      ],
    );
  }
}
