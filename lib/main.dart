import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

void main() {
  return runApp(shopApp());
}

class shopApp extends StatelessWidget {
  // const shopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(

        fontFamily: "TimesNewRoman",

        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Colors.purple.shade400,
          onPrimary: Colors.white,
          secondary: Colors.purple.shade900,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.black,
          background: Colors.white,
          onBackground: Colors.red.shade300,
          surface: Colors.white,
          onSurface: Color.fromARGB(255, 238, 155, 82),
        ),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        
        textTheme: TextTheme(
          displayLarge: TextStyle(fontFamily: "Lato", fontSize: 72.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontFamily: "Lato", fontSize: 36.0, fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(fontFamily: "Lato", fontSize: 25.0, fontWeight: FontWeight.normal),
        ),
      ),
      title: "Shop App",
      home: Products_overview_Screen(),
    );
  }
}