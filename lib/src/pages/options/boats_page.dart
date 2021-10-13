import 'package:flutter/material.dart';

class BoastPage extends StatelessWidget {
  const BoastPage({Key? key}) : super(key: key);

  static const String routeName = '/boats-comodity';
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const BoastPage(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    //TODO: Pasar argumentos entre pantallas
    //final Map args = ModalRoute.of(context)!.settings.arguments;
    final Map<String, dynamic>? arguments =
        (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>);

    return Scaffold(
      appBar: AppBar(
        title: Text(arguments!['name']),
      ),
    );
  }
}
