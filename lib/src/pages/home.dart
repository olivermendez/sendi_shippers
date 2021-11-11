import 'package:flutter/material.dart';
import 'package:my_app/models/token.dart';
import 'package:my_app/src/pages/createshipment.dart';
import 'package:my_app/src/pages/myaccount.dart';
import 'package:my_app/src/pages/myshipments_page.dart';

class Home extends StatefulWidget {
  //final Token token;
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final token = ModalRoute.of(context)!.settings.arguments as Token?;

    List<Widget> _widgetOptions = <Widget>[
      CreateShipmentPage(token: token as Token),
      MyShipmentPage(token: token),
      MyAccountPage(token: token)
    ];
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            // ignore: deprecated_member_use
            title: Text('Create'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            // ignore: deprecated_member_use
            title: Text('My Ship'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            // ignore: deprecated_member_use
            title: Text('My Account'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}
