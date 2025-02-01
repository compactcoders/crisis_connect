import 'package:flutter/material.dart';

class LocationImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/img1.jpg', // Path to your image
      width: 300, // Adjust size as needed
      height: 200,
      fit: BoxFit.cover,
    );
  }
}
