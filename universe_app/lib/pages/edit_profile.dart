import 'package:flutter/material.dart';
import 'package:universe_app/functions/functions.dart';
import 'package:universe_app/pages/feeds.dart';
import 'package:universe_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

// store suser info while they edit their profile
final TextEditingController student_major = TextEditingController();
final TextEditingController student_year = TextEditingController();
final TextEditingController student_birthday = TextEditingController();
final TextEditingController student_residence = TextEditingController();
final TextEditingController best_food = TextEditingController();
final TextEditingController best_movie = TextEditingController();

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    String loggedUserid = Provider.of<UserProvider>(context, listen: false).loggedStudentId;
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
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Color.fromARGB(255, 132, 94, 194),
                  )
                : Container(
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
                          'jermaine.cole@universe.com',
                          style: TextStyle(
                              color: Color.fromRGBO(30, 30, 30, 1),
                              fontSize: 35,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Edit Your Profile',
                          style: TextStyle(
                              color: Color.fromRGBO(30, 30, 30, 1),
                              fontSize: 27,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w200),
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
                                    padding: const EdgeInsets.only(top: 30, bottom: 10, left: 30, right: 30),
                                    child: FractionallySizedBox(
                                      widthFactor: 0.6,
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
                                    padding: const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                                    child: FractionallySizedBox(
                                      widthFactor: 0.6,
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
                                    padding: const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                                    child: FractionallySizedBox(
                                      widthFactor: 0.6,
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
                                    padding: const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                                    child: FractionallySizedBox(
                                      widthFactor: 0.6,
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
                                    padding: const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                                    child: FractionallySizedBox(
                                      widthFactor: 0.6,
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
                                    padding: const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
                                    child: FractionallySizedBox(
                                      widthFactor: 0.6,
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

                        const SizedBox(height: 25),
                        Padding(
                          padding: EdgeInsets.only(left: 175),
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await Navigator.pushNamed(context, '/feeds');
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(99, 99, 99, 1),
                                  minimumSize: const Size(165, 55),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'back',
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontSize: 17,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              const SizedBox(width: 30),
                              ElevatedButton(
                                onPressed: () async {
                                  String studentid = loggedUserid;
                                  print(studentid);
                                  String major = student_major.text;
                                  String year = student_year.text;
                                  String birthday = student_birthday.text;
                                  String residence = student_residence.text;
                                  String bestFood = best_food.text;
                                  String bestMov = best_movie.text;

                                  setState(() {
                                    isLoading = true;
                                  });
                                  await editProfile(
                                      context, studentid, major, year, residence, birthday, bestFood, bestMov);
                                  setState(() {
                                    isLoading = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 132, 94, 194),
                                  minimumSize: const Size(165, 55),
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
                        )
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
