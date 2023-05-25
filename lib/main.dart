import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

import './screens/products_overview_screen.dart';
import './screens/product_Detail_Screen.dart';
import 'providers/product_Hub.dart';
import './screens/cart_Screen.dart';
import './providers/orders.dart';
import './screens/order_Screens.dart';
//
void main() {
  return runApp(shopApp());
  
}

class shopApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => product_Provider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "TimesNewRoman",

          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Colors.purple.shade400,
            onPrimary: Color.fromARGB(255, 255, 255, 255),
            secondary: Colors.purple.shade900,
            onSecondary: Colors.purple.shade300,
            error: Colors.red,
            onError: Colors.black,
            background: Colors.white,
            onBackground: Colors.red.shade300,
            surface: Colors.white,
            onSurface: Color.fromARGB(255, 238, 155, 82),
          ),
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),

          textTheme: const TextTheme(
            displayLarge: TextStyle(
                fontFamily: "Lato",
                fontSize: 72.0,
                fontWeight: FontWeight.bold),
            titleLarge: TextStyle(
                fontFamily: "Lato",
                fontSize: 36.0,
                fontWeight: FontWeight.normal),
            bodyMedium: TextStyle(
                fontFamily: "Lato",
                fontSize: 25.0,
                fontWeight: FontWeight.normal),
            bodySmall: TextStyle(
                fontFamily: "Lato",
                fontSize: 20.0,
                fontWeight: FontWeight.normal),
          ),
        ),
        title: "Shop App",
        home: Products_overview_Screen(),
        routes: {
          ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
          Cart_Screen.routeName: (context) => Cart_Screen(),
          OrderScreen.routeName:(context) => OrderScreen(),
        },
      ),
    );
  }
}


