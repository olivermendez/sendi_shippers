import 'package:flutter/material.dart';
import 'package:my_app/src/widgets/appbar/custom_appbar_category.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: CustomAppBarForCategory(
          categoryName: 'Status',
        ),
        body: Center(
          child: Text("Listing published"),
        ));
  }
}
