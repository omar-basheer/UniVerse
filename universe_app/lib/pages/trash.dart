// import 'package:flutter/material.dart';
// // import 'package:flutter/rendering.dart';

// class Feeds extends StatefulWidget {
//   const Feeds({super.key});

//   @override
//   FeedsState createState() => FeedsState();
// }

// class FeedsState extends State<Feeds> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//           backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//           body: Row(
//             children: [
//               // Left column-Left Half
//               Expanded(
//                 flex: 3,
//                 child: Row(
//                   children: [
//                     // Left column-Left Half-Left Half
//                     Expanded(
//                       flex: 2,
//                       child: Container(
//                         color: Colors.blue,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               width: 50,
//                               height: 50,
//                               color: Colors.yellow,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     // Left column-Left Half-Right Half
//                     Expanded(
//                       flex: 5,
//                       child: Container(
//                         color: Colors.green,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // Right column-Right Half
//               Expanded(
//                 flex: 1,
//                 child: Container(
//                   color: Colors.red,
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }

// class Feeds2State extends State<Feeds> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//         body: Row(
//           children: [
//             // Left Column
//             Expanded(
//               flex: 3,
//               child: Container(
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   // color: Color.fromARGB(255, 153, 42, 42),
//                   color: Color.fromRGBO(245, 244, 244, 1),
//                 ),

//                 child: Row(
//                   children: [
//                     // Left column-Left Half
//                     Expanded(
//                       flex: 1,
//                       child: FractionallySizedBox(
//                         widthFactor: 1,
//                         child: Container(
//                           decoration: const BoxDecoration(
//                             // color: Color.fromRGBO(58, 141, 109, 1),
//                             color: Color.fromRGBO(146, 84, 84, 1),
//                           ),
//                         ),
//                       ),

//                     ),
//                     // Left column - middle menu
//                     Expanded(
//                       flex: 3,
//                       child: Container(
//                         padding: const EdgeInsets.only(right: 30),
//                         decoration: const BoxDecoration(
//                           // color: Color.fromRGBO(51, 99, 123, 1),
//                           color: Color.fromRGBO(51, 65, 109, 1),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: FractionallySizedBox(
//                 widthFactor: 1,
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     color: Color.fromARGB(255, 255, 255, 255),
//                   ),
//                   alignment: Alignment.topCenter,
//                   // Right column Right half
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 55, left:22, right: 22),
//                     child: TextFormField(
//                       decoration: 
//                       InputDecoration(
//                         labelText: 'Search...',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         labelStyle: const TextStyle(
//                           color: Color.fromRGBO(180, 180, 180, 1),
//                           fontFamily: 'Montserrat',
//                           fontSize: 16,
//                           fontWeight: FontWeight.w300,
//                           ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:universe_app/functions/functions.dart';
// import 'package:flutter/rendering.dart';
// import 'package:date_time_picker/date_time_picker.dart';
import 'package:universe_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

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
  // Map<String, dynamic> student_info = {};
  // String loggedmail = '';
  // String loggedid = '';

  // @override
  // void initState() {
  //   super.initState();
  //   _getProfile();
  //   print('got profiles');
  // }

  // Future<void> _getProfile() async {
  //   loggedmail = Provider.of<UserProvider>(context, listen: false).loggedStudentmail;
  //   loggedid = Provider.of<UserProvider>(context, listen: false).loggedInStudentId;
  //   student_info = await getProfile(loggedid);
  //   Map<String, dynamic> profile = student_info['profile'];
  //   Map<String, dynamic> posts = student_info['posts'];
  //   print('decoded json from api');

  //   TextEditingController student_id = TextEditingController(text: profile['id_number']);
  //   TextEditingController first_name = TextEditingController(text: profile['first_name']);
  //   TextEditingController last_name = TextEditingController(text: profile['last_name']);
  //   TextEditingController student_email = TextEditingController(text: profile['email']);
  //   print('set controllers');
  // }

  @override
  Widget build(BuildContext context) {
    String loggedmail = Provider.of<UserProvider>(context, listen: false).loggedStudentmail;
    String loggedid = Provider.of<UserProvider>(context, listen: false).loggedInStudentId;
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
                      child: Column(children: [
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
                              padding: const EdgeInsets.only(top: 30, bottom: 20, left: 30),
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

                            // Column 1
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  // Widgets to stack on top of each other in the first column

                                  Padding(
                                    padding: const EdgeInsets.only(top: 30, bottom: 20, left: 30),
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
                        ),),

                        const SizedBox(height: 15),
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
                            await editProfile(context, loggedid, major, year, birthday, residence, bestFood, bestMov);
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
            
                      ],)
        ),)
        ),
      ),
    );
  }
}