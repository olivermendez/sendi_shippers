import 'package:flutter/material.dart';

class HouseHoldGoodsPage extends StatelessWidget {
  const HouseHoldGoodsPage({Key? key, String? label}) : super(key: key);

  static const String routeName = '/house-hold';
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const HouseHoldGoodsPage(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('label'),
      ),
    );
  }
}
