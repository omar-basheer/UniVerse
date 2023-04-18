import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// my functions
import 'package:universe_app/functions/functions.dart';

// my providers
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

// store stdent id and password entered by user
final TextEditingController student_id = TextEditingController();
final TextEditingController student_pass = TextEditingController();

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            backgroundColor: const Color.fromARGB(255, 132, 94, 194),
            title: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 25, left: 110),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'UniVerse ',
                      style: TextStyle(
                        color: Color.fromRGBO(30, 30, 30, 1),
                        fontFamily: 'Montserrat',
                        // fontFamily: 'Rubik_Pixels',
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
                        // fontStyle: FontStyle.italic
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
        body: Padding(
          padding: const EdgeInsets.only(bottom: 150),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Color.fromARGB(255, 132, 94, 194),
                  )
                : Container(
                    width: 410,
                    height: 400,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 98, 98, 98).withOpacity(0.5),
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
                          'Welcome Back!',
                          style: TextStyle(
                              color: Color.fromRGBO(30, 30, 30, 1),
                              fontSize: 35,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'It\'s Been A Minute Since We Heard From You',
                          style: TextStyle(
                              color: Color.fromRGBO(30, 30, 30, 1),
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w200),
                        ),

                        // id field
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: FractionallySizedBox(
                            widthFactor: 0.75,
                            child: TextFormField(
                              controller: student_id,
                              decoration: InputDecoration(
                                labelText: 'Student Id',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelStyle: const TextStyle(
                                    color: Color.fromRGBO(30, 30, 30, 1),
                                    fontFamily: 'Montserrat',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                        ),

                        // password field
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 20),
                          child: FractionallySizedBox(
                            widthFactor: 0.75,
                            child: TextFormField(
                              obscureText: true,
                              controller: student_pass,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelStyle: const TextStyle(
                                    color: Color.fromRGBO(30, 30, 30, 1),
                                    fontFamily: 'Montserrat',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),

                        // sign in button
                        ElevatedButton(
                          onPressed: () async {
                            String studentId = student_id.text;
                            String password = student_pass.text;
                            setState(() {
                              isLoading = true;
                            });
                            await loginUser(context, studentId, password);
                            setState(() {
                              isLoading = false;
                            });
                            student_pass.clear();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 132, 94, 194),
                            minimumSize: const Size(175, 65),
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
                            'sign in!',
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
    ),);
    
  }
}
