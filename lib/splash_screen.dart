import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add any initialization tasks here (if required)
    // Example: Perform network requests, load data, etc.
    // You can use a Future.delayed to simulate a loading process
    Future.delayed(Duration(seconds: 3), () {
      // Navigate to the main screen after the splash screen
      Navigator.pushReplacementNamed(context, '/main');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set your desired background color
      body: Center(
        child: Image.asset(
            'images/pokeball.png'), // Replace with your splash image asset path
      ),
    );
  }
}
