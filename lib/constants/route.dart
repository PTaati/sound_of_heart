import 'package:flutter/cupertino.dart';
import 'package:sound_of_heart/pages/manual_play_page.dart';

class Routes {
  static Map<String, WidgetBuilder> routes = {
    RouteNames.manualPlayPage: (context) => ManualPlayPage(),
  };
}

class RouteNames {
  static const manualPlayPage = 'manualPlayPage';
}

class RouteParameters {}
