import 'dart:async';

// import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universe_app/functions/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../providers/user_provider.dart';
// import 'package:flutter/rendering.dart';

// store suser info while they create their profile
TextEditingController student_id = TextEditingController();
TextEditingController first_name = TextEditingController();
TextEditingController last_name = TextEditingController();
TextEditingController student_email = TextEditingController();
TextEditingController student_major = TextEditingController();
TextEditingController student_year = TextEditingController();
TextEditingController student_birthday = TextEditingController();
TextEditingController student_residence = TextEditingController();
TextEditingController best_food = TextEditingController();
TextEditingController best_movie = TextEditingController();

class EditProf extends StatefulWidget {
  const EditProf({super.key});

  @override
  EditProfState createState() => EditProfState();
}

class EditProfState extends State<EditProf> {
  bool isLoading = false;
  Map<String, dynamic> student_info = {};
  String loggedmail = '';
  String loggedid = '';
  String loggedname = '';

  @override
  void initState() {
    super.initState();

    setState(() {
      isLoading = true;
    });

    _getProfile();
    print('got profiles');

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _getProfile() async {
    loggedmail = Provider.of<UserProvider>(context, listen: false).loggedStudentmail;
    // loggedmail = 'test@mail.com';
    loggedid = Provider.of<UserProvider>(context, listen: false).loggedInStudentId;
    // loggedid = '54042024';
    loggedname = Provider.of<UserProvider>(context, listen: false).loggedStudentname;

    student_info = await getProfile(loggedid);
    List<dynamic> posts = student_info['posts'];
    Map<String, dynamic> profile = student_info['profile'];
    print('decoded json from api');

    student_id.text = profile['id_number'];
    first_name.text = profile['first_name'];
    last_name.text = profile['last_name'];
    student_email.text = profile['email'];
    student_birthday.text = profile['DOB'];
    best_food.text = profile['best_food'];
    best_movie.text = profile['best_movie'];
    student_residence.text = profile['residence'];
    student_major.text = profile['major'];
    student_year.text = profile['year'];

    print('set controllers');
  }

  @override
  Widget build(BuildContext context) {
    String loggedId = Provider.of<UserProvider>(context, listen: false).loggedStudentId;

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
                                          // loggedid = '';
                                          // loggedname = '';
                                          // loggedmail = '';
                                          Provider.of<UserProvider>(context, listen: false).loggedStudentmail = '';
                                          Provider.of<UserProvider>(context, listen: false).loggedStudentname = '';
                                          Provider.of<UserProvider>(context, listen: false).loggedStudentId = '';
                                          Navigator.restorablePushNamedAndRemoveUntil(
                                              context, '/login', (route) => false);
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

                            // beginning of form
                            Container(
                              child: isLoading
                                  ? const Padding(
                                    padding: EdgeInsets.only(top:300),
                                    child: CircularProgressIndicator(
                                        color: Color.fromARGB(255, 132, 94, 194),
                                      ),
                                  )
                                  : Padding(
                                      padding: const EdgeInsets.only(bottom: 30, top: 15),
                                      child: Center(
                                        child: Container(
                                          width: 700,
                                          height: 650,
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(255, 255, 255, 1),
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 0,
                                                blurRadius: 3,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 35),
                                              Text(
                                                loggedmail,
                                                style: const TextStyle(
                                                    color: Color.fromRGBO(30, 30, 30, 1),
                                                    fontSize: 35,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w300),
                                              ),
                                              const SizedBox(height: 20),
                                              const Text(
                                                'Edit Your Profile',
                                                style: TextStyle(
                                                    color: Color.fromRGBO(30, 30, 30, 1),
                                                    fontSize: 20,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w300),
                                              ),

                                              // profile form starts here
                                              Row(
                                                children: [
                                                  // Column 1
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      children: [
                                                        // Widgets to stack on top of each other in the first column
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 30, bottom: 20, left: 30),
                                                          child: FractionallySizedBox(
                                                            widthFactor: 0.9,
                                                            child: TextFormField(
                                                              controller: student_id,
                                                              style: const TextStyle(
                                                                color: Color.fromARGB(213, 101, 101, 101),
                                                              ),
                                                              enabled: false,
                                                              decoration: InputDecoration(
                                                                labelText: 'Student Id',
                                                                border: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                ),
                                                                labelStyle: const TextStyle(
                                                                    color: Color.fromRGBO(99, 99, 99, 1),
                                                                    fontFamily: 'Montserrat',
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.w300),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 3, bottom: 20, left: 30),
                                                          child: FractionallySizedBox(
                                                            widthFactor: 0.90,
                                                            child: TextFormField(
                                                              controller: first_name,
                                                              style: const TextStyle(
                                                                color: Color.fromARGB(213, 101, 101, 101),
                                                              ),
                                                              enabled: false,
                                                              decoration: InputDecoration(
                                                                labelText: 'First Name',
                                                                border: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                ),
                                                                labelStyle: const TextStyle(
                                                                    color: Color.fromRGBO(99, 99, 99, 1),
                                                                    fontFamily: 'Montserrat',
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.w300),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 3, bottom: 20, left: 30),
                                                          child: FractionallySizedBox(
                                                            widthFactor: 0.90,
                                                            child: TextFormField(
                                                              controller: student_year,
                                                              decoration: InputDecoration(
                                                                labelText: 'Year',
                                                                border: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                ),
                                                                labelStyle: const TextStyle(
                                                                    color: Color.fromRGBO(99, 99, 99, 1),
                                                                    fontFamily: 'Montserrat',
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.w300),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 3, bottom: 20, left: 30),
                                                          child: FractionallySizedBox(
                                                            widthFactor: 0.90,
                                                            child: TextFormField(
                                                              controller: student_birthday,
                                                              decoration: InputDecoration(
                                                                labelText: 'Birthday',
                                                                border: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                ),
                                                                labelStyle: const TextStyle(
                                                                    color: Color.fromRGBO(99, 99, 99, 1),
                                                                    fontFamily: 'Montserrat',
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.w300),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 3, bottom: 20, left: 30),
                                                          child: FractionallySizedBox(
                                                            widthFactor: 0.90,
                                                            child: TextFormField(
                                                              controller: best_food,
                                                              decoration: InputDecoration(
                                                                labelText: 'Best Food',
                                                                border: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                ),
                                                                labelStyle: const TextStyle(
                                                                    color: Color.fromRGBO(99, 99, 99, 1),
                                                                    fontFamily: 'Montserrat',
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.w300),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 15),
                                                      ],
                                                    ),
                                                  ),

                                                  // Column 1
                                                  Expanded(
                                                    flex: 1,
                                                    child: Column(
                                                      children: [
                                                        // Widgets to stack on top of each other in the first column
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(top: 30, bottom: 20, right: 30),
                                                          child: FractionallySizedBox(
                                                            widthFactor: 0.90,
                                                            child: TextFormField(
                                                              controller: student_email,
                                                              style: const TextStyle(
                                                                color: Color.fromARGB(213, 101, 101, 101),
                                                              ),
                                                              enabled: false,
                                                              decoration: InputDecoration(
                                                                labelText: 'Email',
                                                                border: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                ),
                                                                labelStyle: const TextStyle(
                                                                    color: Color.fromRGBO(99, 99, 99, 1),
                                                                    fontFamily: 'Montserrat',
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.w300),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 3, bottom: 20, right: 30),
                                                          child: FractionallySizedBox(
                                                            widthFactor: 0.90,
                                                            child: TextFormField(
                                                              controller: last_name,
                                                              style: const TextStyle(
                                                                color: Color.fromARGB(213, 101, 101, 101),
                                                              ),
                                                              enabled: false,
                                                              decoration: InputDecoration(
                                                                labelText: 'Last Name',
                                                                border: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                ),
                                                                labelStyle: const TextStyle(
                                                                    color: Color.fromRGBO(99, 99, 99, 1),
                                                                    fontFamily: 'Montserrat',
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.w300),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 3, bottom: 20, right: 30),
                                                          child: FractionallySizedBox(
                                                            widthFactor: 0.90,
                                                            child: TextFormField(
                                                              controller: student_major,
                                                              decoration: InputDecoration(
                                                                labelText: 'Major',
                                                                border: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                ),
                                                                labelStyle: const TextStyle(
                                                                    color: Color.fromRGBO(99, 99, 99, 1),
                                                                    fontFamily: 'Montserrat',
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.w300),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 3, bottom: 20, right: 30),
                                                          child: FractionallySizedBox(
                                                            widthFactor: 0.90,
                                                            child: TextFormField(
                                                              controller: student_residence,
                                                              decoration: InputDecoration(
                                                                labelText: 'Residence',
                                                                border: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                ),
                                                                labelStyle: const TextStyle(
                                                                    color: Color.fromRGBO(99, 99, 99, 1),
                                                                    fontFamily: 'Montserrat',
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.w300),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 3, bottom: 20, right: 30),
                                                          child: FractionallySizedBox(
                                                            widthFactor: 0.9,
                                                            child: TextFormField(
                                                              controller: best_movie,
                                                              decoration: InputDecoration(
                                                                labelText: 'Best Movie',
                                                                border: OutlineInputBorder(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                ),
                                                                labelStyle: const TextStyle(
                                                                    color: Color.fromRGBO(99, 99, 99, 1),
                                                                    fontFamily: 'Montserrat',
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.w300),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 15),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 20),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  String major = student_major.text;
                                                  String year = student_year.text;
                                                  String birthday = student_birthday.text;
                                                  String residence = student_residence.text;
                                                  String bestFood = best_food.text;
                                                  String bestMov = best_movie.text;

                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  await editProfile(context, loggedid, major, year, residence, birthday,
                                                      bestFood, bestMov);
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color.fromARGB(255, 132, 94, 194),
                                                  minimumSize: const Size(185, 55),
                                                  shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(15),
                                                      topRight: Radius.circular(15),
                                                      bottomLeft: Radius.circular(15),
                                                      bottomRight: Radius.circular(0),
                                                    ),
                                                  ),
                                                ),
                                                child: const Text(
                                                  'finish!',
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(255, 255, 255, 1),
                                                      fontSize: 17,
                                                      fontFamily: 'Montserrat',
                                                      fontWeight: FontWeight.w400),
                                                ),
                                              ),
                                            ],
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
