import 'package:flutter/material.dart';

import '../../../models/token.dart';

class CustomAppBarShipper extends StatelessWidget {
  final Token token;
  const CustomAppBarShipper({required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color.fromRGBO(3, 9, 23, 1),
      expandedHeight: 70,
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
