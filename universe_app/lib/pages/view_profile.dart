import 'dart:async';

// import 'package:firebase_database/firebase_database.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universe_app/functions/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universe_app/providers/profile_provider.dart';
import '../preferences/dark_mode_service.dart';
import '../providers/user_provider.dart';
// import 'package:flutter/rendering.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  ViewProfileState createState() => ViewProfileState();
}

class ViewProfileState extends State<ViewProfile> {
  bool isLoading = false;
  bool isDark = DarkModeService.getDarkMode();
  Stream<QuerySnapshot> feedsStream = FirebaseFirestore.instance.collection('feeds').snapshots();
  Map<String, dynamic> studentInfo = {};
  Map<String, dynamic> feedInfo = {};

  String loggedmail = '';
  String loggedid = '';
  String loggedname = '';

  String profilemail = '';
  String messageTime = '';
  String profileid = '';

  // store user info while they create their profile
  String? student_id;
  String? first_name;
  String? last_name;
  String? student_email;
  String? student_major;
  String? student_year;
  String? student_birthday;
  String? student_residence;
  String? best_food;
  String? best_movie;

  @override
  void initState() {
    super.initState();

    setState(() {
      isLoading = true;
    });

    _viewProfile().then((value) {
      student_id = value['profile']['id_number'];
      setState(() {
        first_name = value['profile']['first_name'];
        last_name = value['profile']['last_name'];
        student_email = value['profile']['email'];
        student_birthday = value['DOB'];
        best_food = value['profile']['best_food'];
        best_movie = value['profile']['best_movie'];
        student_residence = value['profile']['residence'];
        student_major = value['profile']['major'];
        student_year = value['profile']['year'];
      });
    });

    setState(() {
      isLoading = false;
    });
  }

  Future<Map<String, dynamic>> _viewProfile() async {
    // logged in user provider vars
    loggedmail = Provider.of<UserProvider>(context, listen: false).loggedStudentmail;
    loggedid = Provider.of<UserProvider>(context, listen: false).loggedInStudentId;
    loggedname = Provider.of<UserProvider>(context, listen: false).loggedStudentname;

    // profile providers
    profilemail = Provider.of<ProfileProvider>(context, listen: false).profileMail;
    messageTime = Provider.of<ProfileProvider>(context, listen: false).messageTime;
    profileid = Provider.of<ProfileProvider>(context, listen: false).profileId;

    // check if the view profile page was triggered by tapping a mail or by search using the state of the
    // messageTime provider
    if (messageTime == '') {
      studentInfo = await getProfile(profileid);
    } else {
      // get feed info which contains id
      feedInfo = await viewProfile(messageTime);
      // get profile associated with this id
      profileid = feedInfo['id'];
      studentInfo = await getProfile(profileid);
    }

    Provider.of<ProfileProvider>(context, listen: false).messageTime = '';

    print('decoded json from api');
    return studentInfo;
  }

  @override
  Widget build(BuildContext context) {
    String fname = first_name ?? '';
    String lname = last_name ?? '';
    String mail = student_email ?? '';
    String major = student_major ?? '';
    String year = student_year ?? '';
    String residence = student_residence ?? '';
    String food = best_food ?? '';
    String movie = best_movie ?? '';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: Scaffold(
        backgroundColor: isDark ? backgroundColorDark : backgroundColorLight,
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
                      color: isDark ? backgroundColorDark : backgroundColorLight,
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
                      color: isDark ? backgroundColorDark : backgroundColorLight,
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
                              color: primaryColor,
                              // color: const Color.fromARGB(255, 140, 101, 204),
                              boxShadow: [
                                BoxShadow(
                                  color: isDark ? shadowColorDark : shadowColorLight,
                                  spreadRadius: 0,
                                  blurRadius: 2,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              border: Border.all(
                                color: isDark ? backgroundColorDark : borderColorLight,
                              ),
                            ),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'UniVerse@',
                                    style: TextStyle(
                                      color: Color.fromRGBO(63, 63, 63, 1),
                                      fontFamily: 'Montserrat',
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: loggedname.toLowerCase(),
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
                                color: isDark ? foregroundColorDark : foregroundColorLight,
                                // color: const Color.fromARGB(255, 140, 101, 204),
                                boxShadow: [
                                  BoxShadow(
                                    color: isDark ? shadowColorDark : shadowColorLight,
                                    spreadRadius: 0,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                border: Border.all(
                                  color: isDark ? borderColorDark : borderColorLight,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Stack(children: [
                                      Visibility(
                                        visible: studentInfo.isEmpty,
                                        child: const Padding(
                                          padding: EdgeInsets.only(top: 150),
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              // color: Color.fromARGB(255, 132, 94, 194),
                                              color: primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: !studentInfo.isEmpty,
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
                                                    // child: Icon(
                                                    //   Icons.person,
                                                    //   // size: 100,
                                                    //   ),
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
                                                      children: [
                                                        Text(
                                                          '$fname $lname',
                                                          style: TextStyle(
                                                            fontSize: 24,
                                                            fontWeight: FontWeight.w600,
                                                            color: isDark ? textColorDark3 : textColorLight3,
                                                            // color: Color.fromARGB(255, 97, 194, 94),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 8),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          '$mail ',
                                                          style: const TextStyle(
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w500,
                                                            color: Color.fromARGB(255, 169, 169, 169),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 27),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          '$major |',
                                                          style: TextStyle(
                                                            fontSize: 19,
                                                            fontWeight: FontWeight.w500,
                                                            color: isDark ? textColorDark4 : textColorLight4,
                                                            // color: Color.fromARGB(255, 97, 194, 94),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 8),
                                                        Text(
                                                          '$year |',
                                                          style: TextStyle(
                                                            fontSize: 19,
                                                            fontWeight: FontWeight.w500,
                                                            color: isDark ? textColorDark4 : textColorLight4,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 8),
                                                        Text(
                                                          '$residence ',
                                                          style: TextStyle(
                                                            fontSize: 19,
                                                            fontWeight: FontWeight.w500,
                                                            color: isDark ? textColorDark4 : textColorLight4,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 15),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          '$food, ',
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w300,
                                                            color: isDark ? textColorDark4 : textColorLight5,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 5),
                                                        Text(
                                                          '$movie ',
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w300,
                                                            color: isDark ? textColorDark4 : textColorLight5,
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
                                    ]),
                                  ),

                                  // SizedBox(height: 10,),

                                  Divider(
                                      height: 1,
                                      color: isDark ? backgroundColorLight : Color.fromARGB(255, 161, 161, 161)),

                                  StreamBuilder<QuerySnapshot>(
                                      stream: feedsStream,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                'Error: ${snapshot.error}',
                                                style: TextStyle(
                                                    color: isDark ? textErrorDark : textErrorLight,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          );
                                        }

                                        if (!snapshot.hasData) {
                                          return const Padding(
                                            padding: EdgeInsets.only(top: 150, bottom: 250),
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: primaryColor,
                                                // color: Color.fromARGB(255, 132, 94, 194),
                                              ),
                                            ),
                                          );
                                        }

                                        final feedsList = snapshot.data!.docs;
                                        bool hasFeeds = false;

                                        for (var feed in feedsList) {
                                          if (feed['email'] == student_email) {
                                            hasFeeds = true;
                                            break;
                                          }
                                        }

                                        if (!hasFeeds) {
                                          return const Center(
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 300, bottom: 300),
                                              child: Text(
                                                "no posts yet.",
                                                style: TextStyle(
                                                    color: Color.fromARGB(212, 185, 185, 185),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          );
                                        }

                                        return Expanded(
                                          flex: 3,
                                          child: SingleChildScrollView(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 30),
                                              child: Column(
                                                children: [
                                                  for (var feed in feedsList.reversed)
                                                    if (feed['email'] == student_email)
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

            // search bar
            genSearch(context),
          ],
        ),
      ),
    );
  }
}
