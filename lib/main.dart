import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/productsModalProvider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_Detail_Screen.dart';
import 'providers/product_Hub.dart';
import './screens/cart_Screen.dart';
import './providers/orders.dart';
import './screens/order_Screens.dart';
import './screens/user_product_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_Screen.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';

//
void main() {
  return runApp(shopApp());
}

class shopApp extends StatelessWidget {
  // const shopApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, product_Provider>(
            create: (context) => product_Provider.scndry("", [],""),
            update: (context, auth, previousProduct) => product_Provider.scndry(
              auth.getToken,
              previousProduct!.getProductList() == null
                  ? []
                  : previousProduct.getProductList(),
              auth.getUserId,
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (context) => Orders("default", []),
            update: (context, auth, prevOrders) => Orders(
              auth.getToken,
              prevOrders!.orders == null ? [] : prevOrders.orders,
            ),
          )
        ],
        child: Consumer<Auth>(
          builder: (context, au, _) => MaterialApp(
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
            home:
                au.isAuthenticated ? Products_overview_Screen() : AuthScreen(),
            routes: {
              ProductDetailsScreen.routeName: (context) =>
                  ProductDetailsScreen(),
              Cart_Screen.routeName: (context) => Cart_Screen(),
              OrderScreen.routeName: (context) => OrderScreen(),
              UserProductsScreen.routeName: (context) => UserProductsScreen(),
              EditPrudcutScreen.routeName: (context) => EditPrudcutScreen(),
            },
          ),
        ));
  }
}
