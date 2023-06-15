import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: [
            Image.asset(
              'images/pikachu.gif',
              width: 100,
              height: 70,
            ),
            Positioned(
              child: Image.asset(
                'images/pokemonlogo.png',
                width: 200,
                // height: 200,
              ),
            )
          ],
        ),
      ),
    );
  }
}
