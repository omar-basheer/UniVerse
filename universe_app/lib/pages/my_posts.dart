import 'dart:async';

// import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universe_app/functions/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:universe_app/preferences/dark_mode_service.dart';

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
  bool isDark = DarkModeService.getDarkMode();
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
                              // color: const Color.fromARGB(255, 140, 101, 204),
                              color: primaryColor,
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
                                  padding: EdgeInsets.only(top: 300, bottom: 300),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      // color: Color.fromARGB(255, 132, 94, 194),
                                      color: primaryColor,
                                    ),
                                  ),
                                );
                              }

                              final feedsList = snapshot.data!.docs;
                              print(feedsList.toString());
                              bool hasFeeds = false;

                              for (var feed in feedsList) {
                                if (feed['email'] == loggedmail) {
                                  hasFeeds = true;
                                  break;
                                }
                              }

                              if (!hasFeeds) {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 300, bottom: 300),
                                    child: Text("you have no posts yet. post something to see your posts!!",
                                        style: TextStyle(
                                            // color: Color.fromARGB(212, 185, 185, 185),
                                            color: isDark ? textColorDark2 : textColorLight2,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                );
                              }

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
                                  fillColor: isDark ? fillColorDark : fillColorLight,
                                  hoverColor: isDark ? hoverColorDark : hoverColorLight,
                                  labelText: 'Write Something...',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(22),
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(196, 122, 122, 122),
                                        width: 0.6,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: primaryColor,
                                      // color: Color.fromARGB(255, 132, 94, 194),
                                    ),
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: primaryColor,
                                      // color: Color.fromARGB(255, 132, 94, 194),
                                    ),
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  labelStyle: TextStyle(
                                    color: isDark ? textColorDark : Color.fromARGB(196, 122, 122, 122),
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
                                      color: primaryColor,
                                      // color: Color.fromARGB(255, 132, 94, 194),
                                    ),
                                  ),
                                ),
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

            // search bar
            genSearch(context)
          ],
        ),
      ),
    );
  }
}
