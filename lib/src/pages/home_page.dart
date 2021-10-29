import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/config/constant.dart';
import 'package:my_app/models/commodities.dart';
import 'package:my_app/models/response_options.dart';
import 'package:my_app/src/pages/page_seleted_index.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = '/home';
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const HomePage(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Future<OptionsResponse?> getData() async {
      var url = Uri.parse('${Constants.apiUrl}lookups/commodities/');

      var response = await http.get(
        url,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
      );

      final nowListingResponse = OptionsResponse.fromRawJson(response.body);

      return nowListingResponse;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Que quieres enviar?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromRGBO(37, 59, 128, 5),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, AsyncSnapshot<OptionsResponse?> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text("error"),
              );
            } else {
              return DisplayOptions(snapshot.data!.options.commodities);
            }
          },
        ),
      ),
    );
  }
}

class DisplayOptions extends StatelessWidget {
  final List<Commodity> _optionsToDisplay;
  const DisplayOptions(this._optionsToDisplay);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _optionsToDisplay.length,
        itemBuilder: (context, index) {
          final opt = _optionsToDisplay[index];

          return ListTile(
              title: Text(opt.label),
              subtitle: Text(opt.shortLabel),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubCommoditiePage(
                              seleted: _optionsToDisplay[index],
                            )));
              });
        });
  }
}
