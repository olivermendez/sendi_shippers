import 'package:flutter/material.dart';
import 'package:my_app/models/token.dart';

import '../moving.dart';

class PianosPage extends StatelessWidget {
  final Token token;
  const PianosPage({required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('movieng pianos'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: NewMove(
            token: token,
          ),
        ),
      ),
    );
  }
}
