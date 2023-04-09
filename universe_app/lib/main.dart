import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled= false; // Add this line to hide debug banner
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 219, 217, 219),
        appBar: AppBar(
          title: const Text('buidling rome'),
          backgroundColor: const Color.fromARGB(255, 124, 64, 164),
        ),
        body: const Image(
          image: NetworkImage(
            "https://www.freecodecamp.org/news/content/images/2022/09/jonatan-pie-3l3RwQdHRHg-unsplash.jpg"
          ),
        ),
      ),
    ),
  );
}
