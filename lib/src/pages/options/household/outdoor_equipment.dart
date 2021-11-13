import 'package:flutter/material.dart';
import 'package:my_app/models/token.dart';

import 'moving.dart';

class OutdoorEquipmentPage extends StatelessWidget {
  final Token token;
  const OutdoorEquipmentPage({required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: NewMove(
          token: token,
        ),
      )),
    );
  }
}
