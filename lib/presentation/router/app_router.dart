import 'package:flutter/material.dart';

import '/presentation/screens/home_screen.dart';
import '/presentation/screens/second_screen.dart';
import '/presentation/screens/third_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    final GlobalKey<ScaffoldState> key = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomePage(
            title: "Home Screen",
            color: Colors.blueAccent,
          ),
        );
      case '/second':
        return MaterialPageRoute(
          builder: (_) => SecondScreen(
            title: "Second Screen",
            color: Colors.redAccent,
            homeScreenKey: key,
          ),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (_) => ThirdScreen(
            title: "Third Screen",
            color: Colors.greenAccent,
          ),
        );
      default:
        return null;
    }
  }
}
