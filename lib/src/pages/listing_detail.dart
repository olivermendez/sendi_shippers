import 'package:flutter/material.dart';

class ListindDetailsPage extends StatefulWidget {
  final String listing;
  const ListindDetailsPage({required this.listing, Key? key}) : super(key: key);

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
          Navigator.pop(context);
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
                    Image.network(
                        "https://luxloungeefr.com/wp-content/uploads/2015/03/blue-custom.png"),
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
                          children: const [
                            Text(
                              "Yellow Chair",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 29,
                              ),
                            ),
                            SizedBox(
                              height: 11.0,
                            ),
                            Text(
                              "title",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "description",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
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
