import 'package:flutter/material.dart';
import 'package:my_app/models/bodytypes.dart';
import 'package:my_app/models/token.dart';

class DisplayBodyTypeOptions extends StatelessWidget {
  final Token token;
  final List<Bodytype> bodytypesOptions;
  // ignore: use_key_in_widget_constructors
  const DisplayBodyTypeOptions(this.bodytypesOptions, this.token);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: bodytypesOptions.length,
        itemBuilder: (context, index) {
          final opt = bodytypesOptions[index];
          //final bodySeleted = bodytypesOptions[index].details;
          return Card(
            elevation: 0,
            child: ListTile(
                title: Text(opt.value),
                trailing: const Icon(Icons.arrow_right_alt),
                //subtitle: Text('hola'),
                leading: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 64,
                      minHeight: 64,
                      maxWidth: 64,
                      maxHeight: 64,
                    ),
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/loading.gif'),
                      image: AssetImage("assets/bodytypes/${opt.image}"),
                    )),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => New(
                                token: token,
                                bodySeleted: bodytypesOptions[index],
                                image: opt.image,
                              )));
                }),
          );
        });
  }
}

class New extends StatefulWidget {
  final Bodytype bodySeleted;
  final Token token;
  final String image;
  const New(
      {required this.token,
      required this.bodySeleted,
      required this.image,
      Key? key})
      : super(key: key);

  @override
  State<New> createState() => _New();
}

class _New extends State<New> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String bodytype = '';
  String dimensions = '';
  String weight = '';
  bool operable = false;
  bool convertible = false;
  bool modified = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(" Moving Car Type: " + widget.bodySeleted.value),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: widget.bodySeleted.details.length,
          itemBuilder: (context, index) {
            final opt = widget.bodySeleted.details[index];

            return Form(
              //key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(children: [
                    Expanded(
                      child: Container(
                        color: Colors.amber[30],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Average Dimensions',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                opt.dimensions,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              const Text(
                                'Average Weight',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                opt.weight,
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          height: 150,
                          width: 200,
                          child: FadeInImage(
                            placeholder: const AssetImage('assets/loading.gif'),
                            image:
                                AssetImage("assets/bodytypes/${widget.image}"),
                          )),
                    ),
                  ]),
                  const Divider(),
                  TextFormField(
                    decoration: const InputDecoration(
                      label: Text('Shipment Title'),
                      helperText: 'e.g. 2015 Chevrolet Master',
                      hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                      filled: true,
                      isDense: true,
                    ),
                    onChanged: (value) {
                      // _title = value;
                    },
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                  ),
                  const Divider(
                    height: 20,
                    color: Colors.white,
                  ),
                  TextFormField(
                    maxLines: 3,
                    decoration: const InputDecoration(
                      label: Text('Add description'),
                      //hintText: 'What type of furniture? i.e couch, chair',
                      hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                      filled: true,
                      isDense: true,
                    ),
                    onChanged: (value) {
                      //_description = value;
                    },
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                  ),
                  const Divider(
                    height: 20,
                    color: Colors.white,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        //createListing(context);
                      },
                      child: const Text("Continue")),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
