import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:universe_app/functions/functions.dart';
import 'package:universe_app/preferences/dark_mode_service.dart';
// import 'package:flutter/rendering.dart';
// import 'package:date_time_picker/date_time_picker.dart';

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

final List<String> residenceDropdown = ['on campus', 'off campus'];
final List<String> majorDropdown = ['Computer Science', 'Business Admin', 'Management Systems', 'Engineering'];

String? residenceItem;
String? majorItem;

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  CreateProfileState createState() => CreateProfileState();
}

class CreateProfileState extends State<CreateProfile> {
  bool isLoading = false;
  bool isDark = DarkModeService.getDarkMode();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            backgroundColor: primaryColor,
            // backgroundColor: Color.fromARGB(255, 132, 94, 194),
            title: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 25, left: 140),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'UniVerse ',
                      style: TextStyle(
                        color: Color.fromRGBO(63, 63, 63, 1),
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
        backgroundColor: isDark ? backgroundColorDark : backgroundColorLight,
        // rgba(245, 244, 244, 1)

        // profile box
        body: Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 20),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    // color: Color.fromARGB(255, 132, 94, 194),
                    color: primaryColor,
                  )
                : Container(
                    width: 700,
                    height: 700,
                    decoration: BoxDecoration(
                      color: isDark ? backgroundColorDark : backgroundColorLight,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: isDark ? shadowColorDark : shadowColorLight,
                          spreadRadius: 0,
                          blurRadius: 3,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        color: isDark ? borderColorDark : borderColorLight,
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 35),
                        Text(
                          'Join The UniVerse Community',
                          style: TextStyle(
                              color: isDark ? textColorDark : textColorLight,
                              fontSize: 35,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Create Your Profile',
                          style: TextStyle(
                              color: isDark ? textColorDark : textColorLight,
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
                                          hintText: '########',
                                          hintStyle: const TextStyle(
                                            color: Color.fromRGBO(184, 184, 184, 1),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                              color: isDark ? textColorDark : textColorLight,
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
                                          hintText: 'John',
                                          hintStyle: const TextStyle(
                                            color: Color.fromRGBO(184, 184, 184, 1),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                              color: isDark ? textColorDark : textColorLight,
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
                                          hintText: 'Doe',
                                          hintStyle: const TextStyle(
                                            color: Color.fromRGBO(184, 184, 184, 1),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                              color: isDark ? textColorDark : textColorLight,
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
                                          hintText: 'johndoe@gmail.com',
                                          hintStyle: const TextStyle(
                                            color: Color.fromRGBO(184, 184, 184, 1),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                              color: isDark ? textColorDark : textColorLight,
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
                                        obscureText: true,
                                        controller: student_pass,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          hintText: 'must be at least 8 chars',
                                          hintStyle: const TextStyle(
                                            color: Color.fromRGBO(184, 184, 184, 1),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                              color: isDark ? textColorDark : textColorLight,
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
                                    child: Container(
                                      width: 290,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          hint: Text(
                                            'Major',
                                            style: TextStyle(
                                              color: isDark ? textColorDark : textColorLight,
                                            ),
                                          ),
                                          items: majorDropdown
                                              .map((item) => DropdownMenuItem<String>(value: item, child: Text(item)))
                                              .toList(),
                                          value: majorItem,
                                          onChanged: (value) {
                                            setState(() {
                                              majorItem = value;
                                            });
                                          },
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
                                          hintText: '2024',
                                          hintStyle: const TextStyle(
                                            color: Color.fromRGBO(184, 184, 184, 1),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                              color: isDark ? textColorDark : textColorLight,
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
                                          hintText: 'dd/mm/yy',
                                          hintStyle: const TextStyle(
                                            color: Color.fromRGBO(184, 184, 184, 1),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          labelStyle: TextStyle(
                                              color: isDark ? textColorDark : textColorLight,
                                              fontFamily: 'Montserrat',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 3, bottom: 20, right: 30),
                                    child: Container(
                                      width: 290,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton2(
                                          hint: Text(
                                            'Residence',
                                            style: TextStyle(
                                              color: isDark ? textColorDark : textColorLight,
                                            ),
                                          ),
                                          items: residenceDropdown
                                              .map((item) => DropdownMenuItem<String>(value: item, child: Text(item)))
                                              .toList(),
                                          value: residenceItem,
                                          onChanged: (value) {
                                            setState(() {
                                              residenceItem = value;
                                            });
                                          },
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
                                          labelStyle: TextStyle(
                                              color: isDark ? textColorDark : textColorLight,
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
                                          labelStyle: TextStyle(
                                              color: isDark ? textColorDark : textColorLight,
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
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            String studentId = student_id.text;
                            String fName = first_name.text;
                            String lName = last_name.text;
                            String email = student_email.text;
                            String password = student_pass.text;
                            String major = majorItem.toString();
                            String year = student_year.text;
                            String birthday = student_birthday.text;
                            String residence = residenceItem.toString();
                            String bestFood = best_food.text;
                            String bestMov = best_movie.text;

                            setState(() {
                              isLoading = true;
                            });
                            await createProfile(context, studentId, fName, lName, email, password, major, year,
                                birthday, residence, bestFood, bestMov);
                            setState(() {
                              isLoading = false;
                            });

                            student_id.clear();
                            first_name.clear();
                            last_name.clear();
                            student_email.clear();
                            student_pass.clear();
                            student_major.clear();
                            student_year.clear();
                            student_birthday.clear();
                            student_residence.clear();
                            best_food.clear();
                            best_movie.clear();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            // backgroundColor: const Color.fromARGB(255, 132, 94, 194),
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
