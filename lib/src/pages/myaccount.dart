import 'package:flutter/material.dart';
import 'package:my_app/models/token.dart';

class MyAccountPage extends StatelessWidget {
  Token token;
  MyAccountPage({required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('My Account Page'),
      ),
      body: Center(
        child: Text('my account'),
      ),
    );
  }
}
