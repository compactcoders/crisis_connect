import 'package:flutter/material.dart';
import 'screens/crisis_connect_screen.dart'; // Import your screen

void main() {
  runApp(CrisisApp());
}

class CrisisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes debug banner
      title: 'CrisisConnect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CrisisScreen(), // Set CrisisScreen as home screen
    );
  }
}
