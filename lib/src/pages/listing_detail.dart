import 'package:flutter/material.dart';
import 'package:my_app/models/listing/listing.dart';
import 'package:my_app/models/token.dart';
import 'package:my_app/src/pages/listing_created.dart';

class ListindDetailsPage extends StatefulWidget {
  final Token token;
  final Listing listingCreated;
  const ListindDetailsPage(
      {required this.listingCreated, required this.token, Key? key})
      : super(key: key);

  @override
  _ListindDetailsPageState createState() => _ListindDetailsPageState();
}

class _ListindDetailsPageState extends State<ListindDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xfff7f7f7),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'DELETE',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text(
          "Create Shipment Now",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ListingCreatedPage(token: widget.token)));
        },
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: SizedBox(
                height: 300,
                width: 300,
                child: PageView(
                  children: <Widget>[
                    Image.network(widget.listingCreated.photo),
                    Image.network(
                        "https://luxloungeefr.com/wp-content/uploads/2015/03/blue-custom.png"),
                    Image.network(
                        "https://luxloungeefr.com/wp-content/uploads/2015/03/blue-custom.png"),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.listingCreated.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 29,
                              ),
                            ),
                            const SizedBox(
                              height: 11.0,
                            ),
                            Text(
                              widget.listingCreated.title,
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              widget.listingCreated.description,
                              style: TextStyle(color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 11.0,
                            ),
                          ],
                        )
                      ],
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 11.0,
                    ),
                    const Text(
                      "Dimensions:",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    const Text(
                      "Dimensions: H 33 x W 19 x D 21: Seati, All dimensions are in INCH",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 11.0,
                    ),
                    const Text(
                      "Route",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    const Text(
                      "PolyPurulent Fabric, ",
                      style: TextStyle(color: Colors.grey),
                    ),
                    const Text(
                      "PolyPurulent Fabric, High Quality Wood, High Quality Leather",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
