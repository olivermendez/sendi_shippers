import 'package:flutter/material.dart';

class BoastPage extends StatelessWidget {
  const BoastPage({Key? key, String? label}) : super(key: key);

  static const String routeName = '/boats-comodity';
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const BoastPage(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('boast'),
      ),
    );
  }
}
