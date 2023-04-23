import 'dart:async';

// import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universe_app/functions/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/user_provider.dart';
// import 'package:flutter/rendering.dart';

final TextEditingController studentsId = TextEditingController();
final TextEditingController postMessage = TextEditingController();

class MyPosts extends StatefulWidget {
  const MyPosts({super.key});

  @override
  MyPostsState createState() => MyPostsState();
}

class MyPostsState extends State<MyPosts> {
  bool isLoading = false;
  Stream<QuerySnapshot> feedsStream = FirebaseFirestore.instance.collection('feeds').snapshots();

  @override
  void initState() {
    super.initState();
    print('feedStream initialized');
  }

  @override
  Widget build(BuildContext context) {
    String loggedname = Provider.of<UserProvider>(context, listen: false).loggedStudentname;
    String loggedId = Provider.of<UserProvider>(context, listen: false).loggedStudentId;
    String loggedmail = Provider.of<UserProvider>(context, listen: false).loggedStudentmail;
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
                            // sticky side-menu bar
                            Container(
                              padding: const EdgeInsets.only(bottom: 20),
                              width: 180,
                              height: 350,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: const Color.fromARGB(255, 132, 94, 194),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 98, 98, 98).withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20, left: 34, right: 0, bottom: 0),
                                // menu items
                                child: Container(
                                  child: Column(
                                    children: [
                                      // single button starts here
                                      const SizedBox(height: 25),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context, '/home');
                                        },
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.home,
                                              size: 30,
                                              color: Color.fromARGB(255, 245, 245, 245),
                                            ),
                                            SizedBox(width: 15),
                                            Text(
                                              'Home',
                                              style: TextStyle(
                                                  color: Color.fromARGB(255, 245, 245, 245),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      ),
                                      // single button ends here

                                      // single button starts here
                                      const SizedBox(height: 25),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context, '/feeds');
                                        },
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.question_answer,
                                              size: 30,
                                              color: Color.fromARGB(255, 245, 245, 245),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              'Feeds',
                                              style: TextStyle(
                                                  color: Color.fromARGB(255, 245, 245, 245),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      ),
                                      // single button ends here

                                      // single button starts here
                                      const SizedBox(height: 25),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context, '/my-posts');
                                        },
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.bookmark,
                                              size: 30,
                                              color: Color.fromARGB(255, 245, 245, 245),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              'My Posts',
                                              style: TextStyle(
                                                  color: Color.fromARGB(255, 245, 245, 245),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      ),
                                      // single button ends here

                                      // single button starts here
                                      const SizedBox(height: 25),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context, '/edit-profile');
                                        },
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.people,
                                              size: 30,
                                              color: Color.fromARGB(255, 245, 245, 245),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              'Profile',
                                              style: TextStyle(
                                                  color: Color.fromARGB(255, 245, 245, 245),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      ),
                                      // single button ends here

                                      // single button starts here
                                      const SizedBox(height: 25),
                                      GestureDetector(
                                        onTap: () {
                                          // loggedId = '';
                                          // loggedname = '';
                                          // loggedmail = '';
                                          Provider.of<UserProvider>(context, listen: false).loggedStudentmail = '';
                                          Provider.of<UserProvider>(context, listen: false).loggedStudentname = '';
                                          Provider.of<UserProvider>(context, listen: false).loggedStudentId= '';
                                          Navigator.restorablePushNamedAndRemoveUntil(context, '/login', (route) => false );
                                        },
                                        child: Row(
                                          children: const [
                                            Icon(
                                              Icons.logout,
                                              size: 30,
                                              color: Color.fromARGB(255, 245, 245, 245),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              'LogOut',
                                              style: TextStyle(
                                                  color: Color.fromARGB(255, 245, 245, 245),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      ),
                                      // single button ends here
                                    ],
                                  ),
                                ),
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

                            //sticky top menu bar
                            Container(
                              padding: const EdgeInsets.only(top: 12, left: 5, right: 15),
                              width: 900,
                              height: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: const Color.fromARGB(255, 140, 101, 204),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 98, 98, 98).withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'UniVerse@',
                                      style: TextStyle(
                                        color: Color.fromRGBO(30, 30, 30, 1),
                                        fontFamily: 'Montserrat',
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: loggedname,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Montserrat',
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: feedsStream,
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error: ${snapshot.error}'),
                                  );
                                }

                                if (!snapshot.hasData) {
                                  return const Padding(
                                    padding: EdgeInsets.only(top:300, bottom: 300),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Color.fromARGB(255, 132, 94, 194),
                                      ),
                                    ),
                                  );
                                }

                                final feedsList = snapshot.data!.docs;

                                return Expanded(
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 30, right: 20),
                                      child: Column(
                                        children: [
                                          for (var feed in feedsList.reversed)
                                            if (feed['email'] == loggedmail)
                                              genLoggedFeed(context, feed['email'], feed['message'], feed['timestamp'])
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),

                            Container(
                              padding: const EdgeInsets.only(top: 12, left: 5, right: 15, bottom: 20),
                              child: Opacity(
                                opacity: 0.8,
                                child: TextFormField(
                                  controller: postMessage,
                                  style: const TextStyle(
                                      color: Color.fromARGB(213, 101, 101, 101),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: const Color.fromRGBO(255, 255, 255, 1),
                                      hoverColor: const Color.fromRGBO(255, 255, 255 , 1),
                                      labelText: 'Write Something...',
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(22),
                                          borderSide: const BorderSide(
                                            color: Color.fromARGB(196, 122, 122, 122),
                                            width: 0.6,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color.fromARGB(255, 132, 94, 194),
                                        ),
                                        borderRadius: BorderRadius.circular(22),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Color.fromARGB(255, 132, 94, 194),
                                        ),
                                        borderRadius: BorderRadius.circular(22),
                                      ),
                                      labelStyle: const TextStyle(
                                        color: Color.fromARGB(196, 122, 122, 122),
                                        fontFamily: 'Montserrat',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          String message = postMessage.text;
                                          if (message != "") {
                                            createPost(context, loggedId, message);
                                            postMessage.clear();
                                          }
                                        },
                                        child: const Icon(
                                          Icons.near_me,
                                          size: 20,
                                          color: Color.fromARGB(255, 132, 94, 194),
                                        ),
                                      )),
                                ),
                              ),
                            ),
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
                        padding: const EdgeInsets.only(top: 55, left: 16, right: 16),
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