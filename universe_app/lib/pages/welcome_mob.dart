import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

class WelcomeScreenMob extends StatefulWidget {
  const WelcomeScreenMob({super.key});

  @override
  WelcomeState createState() => WelcomeState();
}

class WelcomeState extends State<WelcomeScreenMob> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 251, 251, 251),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 200),
            child: Container(
            width: 245,
            height: 250,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 132, 94, 194),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 37, 37, 37).withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: const Offset(2, 2)
                )
              ],
            ),
          )
          )
        ),
      ),
    );
  }
}
