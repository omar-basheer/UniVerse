import 'dart:async';

// import 'package:firebase_database/firebase_database.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universe_app/functions/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universe_app/providers/profile_provider.dart';
import '../providers/user_provider.dart';
// import 'package:flutter/rendering.dart';

// store suser info while they create their profile
String student_id =  '';
String first_name =  '';
String last_name =  '';
String student_email =  '';
String student_major =  '';
String student_year =  '';
String student_birthday = '';
String student_residence =  '';
String best_food = '';
String best_movie =  '';

// final List<String> residenceDropdown = ['on campus', 'off campus'];
// final List<String> majorDropdown = ['Computer Science', 'Business Admin', 'Management Systems', 'Engineering'];

// String? residenceItem;
// String? majorItem;

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  ViewProfileState createState() => ViewProfileState();
}

class ViewProfileState extends State<ViewProfile> {
  bool isLoading = false;
  Stream<QuerySnapshot> feedsStream = FirebaseFirestore.instance.collection('feeds').snapshots();
  Map<String, dynamic> studentInfo = {};
  Map<String, dynamic> feedInfo = {};

  String loggedmail = '';
  String loggedid = '';
  String loggedname = '';

  String profilemail = '';
  String messageTime = '';
  String profileid = '';

  @override
  void initState() {
    super.initState();

    setState(() {
      isLoading = true;
    });

    _viewProfile();
    print('got profiles');

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _viewProfile() async {
    // logged in user provider vars
    loggedmail = Provider.of<UserProvider>(context, listen: false).loggedStudentmail;
    loggedid = Provider.of<UserProvider>(context, listen: false).loggedInStudentId;
    loggedname = Provider.of<UserProvider>(context, listen: false).loggedStudentname;

    // profile providers
    profilemail = Provider.of<ProfileProvider>(context, listen: false).profileMail;
    messageTime = Provider.of<ProfileProvider>(context, listen: false).messageTime;

    // get feed info which contains id
    feedInfo = await viewProfile(messageTime);
    // print(feed_info.toString());

    // get profile associated with this id
    profileid = feedInfo['id'];
    studentInfo = await getProfile(profileid);
    print(studentInfo.toString());

    print('decoded json from api');

    student_id = studentInfo['id_number'];
    first_name = studentInfo['first_name'];
    last_name = studentInfo['last_name'];
    student_email = studentInfo['email'];
    student_birthday = studentInfo['DOB'];
    best_food = studentInfo['best_food'];
    best_movie = studentInfo['best_movie'];
    student_residence = studentInfo['residence'];
    student_major = studentInfo['major'];
    student_year = studentInfo['year'];

    print('set controllers');
  }

  @override
  Widget build(BuildContext context) {
    // String loggedId = Provider.of<UserProvider>(context, listen: false).loggedStudentId;
    // print(student_id.text);

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
                            showSideMenubar(context)
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
                                color: const Color.fromARGB(255, 97, 194, 94),
                                // color: const Color.fromARGB(255, 140, 101, 204),
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

                            Padding(
                              padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
                              child: Container(
                                width: 900,
                                height: 700,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17),
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                  // color: const Color.fromARGB(255, 140, 101, 204),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromARGB(255, 98, 98, 98).withOpacity(0.5),
                                      spreadRadius: 0,
                                      blurRadius: 2,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 30, top: 20, bottom: 20),
                                            child: Container(
                                              width: 300,
                                              height: 300,
                                              // color: Colors.blue,
                                              child: const Center(
                                                child: CircleAvatar(
                                                  radius: 130,
                                                  backgroundColor: Color.fromARGB(212, 192, 192, 192),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              // color: Colors.amber,
                                              padding: const EdgeInsets.only(left: 10, top: 60),
                                              child: Column(
                                                children: [
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children:  [
                                                      Text(
                                                        '$first_name $last_name',
                                                        style: const TextStyle(
                                                            fontSize: 24,
                                                            fontWeight: FontWeight.w600,
                                                            color: Color.fromARGB(255, 54, 54, 54)
                                                            // color: Color.fromARGB(255, 97, 194, 94),
                                                            ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children:  [
                                                      Text(
                                                        student_email,
                                                        style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight: FontWeight.w500,
                                                          color: Color.fromARGB(255, 169, 169, 169),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 30),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children:  [
                                                      Text(
                                                        '$student_major |',
                                                        style: const TextStyle(
                                                            fontSize: 19,
                                                            fontWeight: FontWeight.w500,
                                                            color: Color.fromARGB(255, 54, 54, 54)
                                                            // color: Color.fromARGB(255, 97, 194, 94),
                                                            ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        '$student_year |',
                                                        style: const TextStyle(
                                                          fontSize: 19,
                                                          fontWeight: FontWeight.w500,
                                                          color: Color.fromARGB(255, 54, 54, 54),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        '$student_residence |',
                                                        style: const TextStyle(
                                                          fontSize: 19,
                                                          fontWeight: FontWeight.w500,
                                                          color: Color.fromARGB(255, 54, 54, 54),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children:  [
                                                      Text(
                                                        '($best_food, ',
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w300,
                                                          color: Color.fromARGB(255, 139, 139, 139),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                          '$best_movie)',
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w300,
                                                          color: Color.fromARGB(255, 139, 139, 139),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // SizedBox(height: 10,),

                                    const Divider(height: 1, color: Color.fromARGB(255, 161, 161, 161)),

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
                                              padding: EdgeInsets.only(top: 350, bottom: 200),
                                              child: Center(
                                                child: CircularProgressIndicator(
                                                  color: Color.fromARGB(255, 97, 194, 94),
                                                  // color: Color.fromARGB(255, 132, 94, 194),
                                                ),
                                              ),
                                            );
                                          }

                                          final feedsList = snapshot.data!.docs;

                                          return Expanded(
                                            flex: 3,
                                            child: SingleChildScrollView(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 30),
                                                child: Column(
                                                  children: [
                                                    for (var feed in feedsList.reversed)
                                                      if (feed['email'] == profilemail)
                                                        genLoggedFeed(
                                                            context, feed['email'], feed['message'], feed['timestamp'])
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        })
                                  ],
                                ),
                              ),
                            )
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
