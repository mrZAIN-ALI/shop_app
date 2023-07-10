import 'package:flutter/material.dart';

class CustomRouteTransation<T> extends MaterialPageRoute<T> {
  CustomRouteTransation(
      {required WidgetBuilder Builder, required RouteSettings settings})
      : super(
          builder: Builder,
          settings: settings,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // TODO: implement buildTransitions
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(1.0, 0.0), // Slide from right to left
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}

class customPageTranstion extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    // TODO: implement buildTransitions
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.75, // Start with no scale (hidden)
        end: 1.0, // Scale to full size
      ).animate(animation),
      child: child,
    );
  }
}
