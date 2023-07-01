
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
    
        body: Center(
          child: Text("Loading Data Please Wait...",textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}
