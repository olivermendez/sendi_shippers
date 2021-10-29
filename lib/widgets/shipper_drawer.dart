import 'package:flutter/material.dart';

class ShipperDrawer extends StatefulWidget {
  ShipperDrawer({Key? key}) : super(key: key);

  @override
  _ShipperDrawerState createState() => _ShipperDrawerState();
}

class _ShipperDrawerState extends State<ShipperDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        //color: Colors.black87,
        child: ListView(
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        height: 80,
                        width: 80,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940")),
                          shape: BoxShape.circle,
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 45.0, left: 20),
                      child: Column(
                        children: [
                          Text("name"),
                          Text("username"),
                        ],
                      ),
                    ),
                  ],
                )),
            Container(
              color: Colors.white,
              child: const ListTile(
                title: Text(
                  "Metodos de Pagos",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: const ListTile(
                title: Text(
                  "Tus viajes",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: const ListTile(
                title: Text(
                  "Configuracion",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: const ListTile(
                title: Text(
                  "Ayuda",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
