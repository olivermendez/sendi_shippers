import 'package:flutter/material.dart';
import 'package:my_app/src/pages/home_page.dart';
import 'package:my_app/src/pages/options/boats_page.dart';
import 'package:my_app/src/pages/options/household_goods_page.dart';
import 'package:my_app/src/pages/options/vehicles_page.dart';
import 'package:my_app/src/pages/register_page.dart';
import 'package:my_app/src/pages/welcome_page.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // ignore: avoid_print
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/welcome':
        return WelcomePage.route();
      case HomePage.routeName:
        return HomePage.route();
      case RegisterPage.routenName:
        return RegisterPage.route();

      //COMMODITIES
      case HouseHoldGoodsPage.routeName:
        return HouseHoldGoodsPage.route();

      case BoastPage.routeName:
        return BoastPage.route();

      case VehiclePageCommodity.routeName:
        return VehiclePageCommodity.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('Page not defined'),
              ),
            ),
        settings: const RouteSettings(name: '/error'));
  }
}
