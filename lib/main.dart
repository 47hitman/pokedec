// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(Pokemon());
}

class Pokemon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
