import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/config/constant.dart';
import 'package:my_app/models/commodities.dart';
import 'package:my_app/models/response_options.dart';
import 'package:my_app/models/token.dart';
import 'package:my_app/src/pages/page_seleted_index.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/widgets/shipper_drawer.dart';

class CreateShipmentPage extends StatefulWidget {
  final Token token;
  const CreateShipmentPage({required this.token, Key? key}) : super(key: key);

  @override
  State<CreateShipmentPage> createState() => _CreateShipmentPageState();
}

class _CreateShipmentPageState extends State<CreateShipmentPage> {
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

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _CustomAppBar(token: widget.token),
          SliverFillRemaining(
            child: FutureBuilder(
              future: getData(),
              builder: (context, AsyncSnapshot<OptionsResponse?> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return DisplayOptions(
                      snapshot.data!.options.commodities, widget.token);
                }
              },
            ),
          ),
        ],
      ),
      drawer: ShipperDrawer(token: widget.token),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Token token;
  const _CustomAppBar({required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      //backgroundColor: Color.fromRGBO(37, 59, 128, 5),
      backgroundColor: const Color.fromRGBO(3, 9, 23, 1),
      //expandedHeight: 90,
      pinned: true,
      title: Text(
        "Hi, ${token.user.name} \nWhat do you want ship?",
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),

      centerTitle: false,
      flexibleSpace: const FlexibleSpaceBar(
        //titlePadding: EdgeInsets.all(0),
        //centerTitle: true,
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: AssetImage('assets/truck.png'),
          fit: BoxFit.scaleDown,
          alignment: Alignment.bottomRight,
        ),
      ),
    );
  }
}

class DisplayOptions extends StatelessWidget {
  final Token token;
  final List<Commodity> _optionsToDisplay;
  const DisplayOptions(this._optionsToDisplay, this.token);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _optionsToDisplay.length,
        itemBuilder: (context, index) {
          final opt = _optionsToDisplay[index];

          return Card(
            elevation: 1,
            child: ListTile(
                title: Text(opt.label),
                subtitle: Text(opt.shortLabel),
                leading: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 64,
                      minHeight: 64,
                      maxWidth: 64,
                      maxHeight: 64,
                    ),
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/loading.gif'),
                      image: AssetImage("assets/${opt.route}"),
                    )),
                //subtitle: Text(opt.shortLabel),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SubCommoditiePage(
                                seleted: _optionsToDisplay[index],
                                token: token,
                              )));
                }),
          );
        });
  }
}
