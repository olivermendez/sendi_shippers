import 'package:flutter/material.dart';
import 'package:my_app/models/token.dart';
import 'package:my_app/src/widgets/appbar/custom_appbar_category.dart';

class ConfirmationPage extends StatelessWidget {
  final Token token;

  const ConfirmationPage({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBarForCategory(
          categoryName: 'Status',
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text("Listing published"),
            ),
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
