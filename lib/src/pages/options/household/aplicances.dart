import 'package:flutter/material.dart';
import 'package:my_app/models/token.dart';
import 'package:my_app/src/pages/options/household/moving.dart';

class AppliancesPage extends StatelessWidget {
  final Token token;
  const AppliancesPage({required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
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
