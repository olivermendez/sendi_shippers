import 'package:flutter/material.dart';
import 'package:my_app/models/token.dart';
import 'package:my_app/src/widgets/appbar/custom_appbar_category.dart';

class ConfirmationPage extends StatelessWidget {
  final Token token;

  const ConfirmationPage({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        appBar: const CustomAppBarForCategory(
          categoryName: 'Status',
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Listing published",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'home', (route) => false,
                      arguments: token);
                },
                child: const Text("Go home"))
          ],
        ));
  }
}
