import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.black,
          background: Colors.white,
          onBackground: Colors.red.shade300,
          surface: Colors.white,
          onSurface: Color.fromARGB(255, 238, 155, 82),
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 24.0,),
        ),
      ),
      title: "Shop App",
      home: _shopApp_HomePage(),
    );
  }
}

class _shopApp_HomePage extends StatelessWidget {
  // const _shopApp_HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shoping App"),
      ),
      body: Center(
        child: Text("Woa Welcom You Shoping"),
      ),
    );
  }
}
