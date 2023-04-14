import 'package:flutter/material.dart';
import 'package:universe_app/functions/functions.dart';
// import 'package:flutter/rendering.dart';

// store suser info while they create their profile
final TextEditingController student_id = TextEditingController();
final TextEditingController first_name = TextEditingController();
final TextEditingController last_name = TextEditingController();
final TextEditingController student_email = TextEditingController();
final TextEditingController student_pass = TextEditingController();
final TextEditingController student_major = TextEditingController();
final TextEditingController student_year = TextEditingController();
final TextEditingController student_birthday = TextEditingController();
final TextEditingController student_residence = TextEditingController();
final TextEditingController best_food = TextEditingController();
final TextEditingController best_movie = TextEditingController();

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  CreateProfileState createState() => CreateProfileState();
}

class CreateProfileState extends State<CreateProfile> {
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
          padding: const EdgeInsets.only(bottom: 10, top: 20),
          child: Center(
            child: Container(
              width: 700,
              height: 700,
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
                  const Text(
                    'Join The UniVerse Community',
                    style: TextStyle(
                        color: Color.fromRGBO(30, 30, 30, 1),
                        fontSize: 35,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Create Your Profile',
                    style: TextStyle(
                        color: Color.fromRGBO(30, 30, 30, 1),
                        fontSize: 14,
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
                                  controller: last_name,
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
                              padding: const EdgeInsets.only(top: 3, bottom: 20, left: 30),
                              child: FractionallySizedBox(
                                widthFactor: 0.90,
                                child: TextFormField(
                                  controller: student_email,
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
                              padding: const EdgeInsets.only(top: 3, bottom: 20, left: 30),
                              child: FractionallySizedBox(
                                widthFactor: 0.90,
                                child: TextFormField(
                                  controller: student_pass,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
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
                            const SizedBox(height: 75),
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
                              padding: const EdgeInsets.only(top: 3, bottom: 20, right: 30),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      String studentId = student_id.text;
                      String fName = first_name.text;
                      String lName = last_name.text;
                      String email = student_email.text;
                      String password = student_pass.text;
                      String major = student_major.text;
                      String year = student_year.text;
                      String birthday = student_birthday.text;
                      String residence = student_residence.text;
                      String bestFood = best_food.text;
                      String bestMov = best_movie.text;
                     createProfile(context, studentId, fName, lName, email, password, major, year, residence, birthday, bestFood, bestMov);
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
                      'sign up!',
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
