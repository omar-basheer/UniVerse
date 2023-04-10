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
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          body: Row(
            children: [
              // Left column-Left Half
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    // Left column-Left Half-Left Half
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: const Color.fromRGBO(245, 244, 244, 1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 20),
                              width: 180,
                              height: 350,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: const Color.fromARGB(255, 132, 94, 194),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Left column-Left Half-Right Half
                    Expanded(
                      flex: 4,
                      child: Container(
                        color: const Color.fromRGBO(245, 244, 244, 1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 10, right: 10),
                            ),
                            Container(
                                padding: const EdgeInsets.only(top: 15),
                                width: 900,
                                height: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17),
                                  color:
                                      Color.fromRGBO(132, 94, 194, 1),
                                ),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'UniVerse',
                                        style: TextStyle(
                                          color: Color.fromRGBO(30, 30, 30, 1),
                                          fontFamily: 'Montserrat',
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '@jermaine.cole',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Right column-Right Half
              Expanded(
                flex: 1,
                child: Container(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: Container(
                      alignment: Alignment.topCenter,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 55, left: 16, right: 16),
                        child: TextFormField(
                          decoration: InputDecoration(
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
              ),
            ],
          )),
    );
  }
}



            // Expanded(
            //   flex: 1,
            //   child: FractionallySizedBox(
            //     widthFactor: 1,
            //     child: Container(
            //       decoration: const BoxDecoration(
            //         color: Color.fromARGB(255, 255, 255, 255),
            //       ),
            //       alignment: Alignment.topCenter,
            //       // Right column Right half
            //       child: Padding(
            //         padding: const EdgeInsets.only(top: 55, left:22, right: 22),
            //         child: TextFormField(
            //           decoration: 
            //           InputDecoration(
            //             labelText: 'Search...',
            //             border: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(10),
            //             ),
            //             labelStyle: const TextStyle(
            //               color: Color.fromRGBO(180, 180, 180, 1),
            //               fontFamily: 'Montserrat',
            //               fontSize: 16,
            //               fontWeight: FontWeight.w300,
            //               ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),