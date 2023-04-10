import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

class Feeds extends StatefulWidget {
  const Feeds({super.key});

  @override
  FeedsState createState() => FeedsState();
}

class FeedsState extends State<Feeds> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          body: Row(
            children: [
              // Left column-Left Half
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    // Left column-Left Half-Left Half
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              color: Colors.yellow,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Left column-Left Half-Right Half
                    Expanded(
                      flex: 5,
                      child: Container(
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              // Right column-Right Half
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.red,
                ),
              ),
            ],
          )),
    );
  }
}

class Feeds2State extends State<Feeds> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Row(
          children: [
            // Left Column
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  // color: Color.fromARGB(255, 153, 42, 42),
                  color: Color.fromRGBO(245, 244, 244, 1),
                ),

                child: Row(
                  children: [
                    // Left column-Left Half
                    Expanded(
                      flex: 1,
                      child: FractionallySizedBox(
                        widthFactor: 1,
                        child: Container(
                          decoration: const BoxDecoration(
                            // color: Color.fromRGBO(58, 141, 109, 1),
                            color: Color.fromRGBO(146, 84, 84, 1),
                          ),
                        ),
                      ),

                    ),
                    // Left column - middle menu
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.only(right: 30),
                        decoration: const BoxDecoration(
                          // color: Color.fromRGBO(51, 99, 123, 1),
                          color: Color.fromRGBO(51, 65, 109, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  alignment: Alignment.topCenter,
                  // Right column Right half
                  child: Padding(
                    padding: const EdgeInsets.only(top: 55, left:22, right: 22),
                    child: TextFormField(
                      decoration: 
                      InputDecoration(
                        labelText: 'Search...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelStyle: const TextStyle(
                          color: Color.fromRGBO(180, 180, 180, 1),
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}