import 'package:flutter/material.dart';
import 'package:my_app/models/commodities.dart';

class SubCommoditiePage extends StatefulWidget {
  final Commodity seleted;
  const SubCommoditiePage({required this.seleted, Key? key}) : super(key: key);

  static const String routenName = 'detail';

  @override
  _SubCommoditiePageState createState() => _SubCommoditiePageState();
}

class _SubCommoditiePageState extends State<SubCommoditiePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.seleted.label),
          backgroundColor: const Color.fromRGBO(37, 59, 128, 5),
        ),
        body: ListView.builder(
            itemCount: widget.seleted.subCommodities.length,
            itemBuilder: (context, index) {
              final opt = widget.seleted.subCommodities[index];
              return ListTile(
                title: Text(opt.label),
                onTap: () {},
              );
            }));
  }
}
