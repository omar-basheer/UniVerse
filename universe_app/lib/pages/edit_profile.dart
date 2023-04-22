import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universe_app/functions/functions.dart';
import 'dart:html' as html;

import '../providers/user_provider.dart';
// import 'package:flutter/rendering.dart';
// import 'package:date_time_picker/date_time_picker.dart';

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

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  bool isLoading = false;
  Map<String, dynamic> student_info = {};
  String loggedmail = '';
  String loggedid = '';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            backgroundColor: const Color.fromARGB(255, 132, 94, 194),
            title: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 25, left: 140),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'UniVerse ',
                      style: TextStyle(
                        color: Color.fromRGBO(30, 30, 30, 1),
                        fontFamily: 'Montserrat',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Desktop',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(245, 244, 244, 1),
        // rgba(245, 244, 244, 1)

        // profile box
        body: Padding(
          padding: const EdgeInsets.only(bottom: 30, top: 15),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Color.fromARGB(255, 132, 94, 194),
                  )
                : Container(
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
                                    padding: const EdgeInsets.only(top: 30, bottom: 20, right: 30),
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
                            await editProfile(context, loggedid, major, year, residence, birthday, bestFood, bestMov);
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
    );
  }
}
