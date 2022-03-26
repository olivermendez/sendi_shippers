import 'package:flutter/material.dart';
import 'package:my_app/models/token.dart';
import 'package:my_app/src/pages/home/home.dart';

class ListingCreatedPage extends StatelessWidget {
  final Token token;
  const ListingCreatedPage({required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: const Center(
        child: Text('Listing created'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false,
              arguments: token);
        },
        child: const Text('Go home'),
      ),
    );
  }
}
