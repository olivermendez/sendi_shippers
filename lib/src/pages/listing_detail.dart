import 'package:flutter/material.dart';

class ListindDetailsPage extends StatefulWidget {
  final String listing;
  ListindDetailsPage({required this.listing, Key? key}) : super(key: key);

  @override
  _ListindDetailsPageState createState() => _ListindDetailsPageState();
}

class _ListindDetailsPageState extends State<ListindDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moving product: ' + widget.listing),
        backgroundColor: Colors.black87,
      ),
    );
  }
}
