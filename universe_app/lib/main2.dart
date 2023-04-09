import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 219, 217, 219),
        appBar: AppBar(
          title: const Text(
            'UniVerse',
            style: TextStyle(color: Colors.black)
          ),
          backgroundColor: const Color.fromARGB(255, 124, 64, 164),
        ),
        body: const Center(
          child: Text('welcome'),
        ),
      ),
    ),
  );
}     
          