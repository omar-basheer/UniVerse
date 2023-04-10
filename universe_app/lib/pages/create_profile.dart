import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

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
          body: Padding(
            padding: const EdgeInsets.only(bottom: 150),
            child: Center(
              child: Container(
                width: 410,
                height: 400,
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
                  children: const [
                    SizedBox(height: 35),
                    Text(
                      'Join The UniVerse Community',
                      style: TextStyle(
                          color: Color.fromRGBO(30, 30, 30, 1),
                          fontSize: 35,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w300),
                    ),

                    SizedBox(height: 20),
                    Text(
                      'Create Your Profile',
                      style: TextStyle(
                          color: Color.fromRGBO(30, 30, 30, 1),
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w300),
                    ),

                    // const SizedBox(height: 35),
                    // TextFormField(
                    //   decoration: const InputDecoration(
                    //     labelText: 'Student ID',
                    //     border: OutlineInputBorder()
                    //     ),
                    // ),

                    // const SizedBox(height: 35),
                    // TextFormField(
                    //   decoration: const InputDecoration(
                    //     labelText: 'Password',
                    //     border: OutlineInputBorder()
                    //     ),
                    // ),

                    // const SizedBox(height: 15),
                    // ElevatedButton(
                    //   onPressed: (){
                    //     Navigator.pushNamed(context, '/home');
                    //   },
                    //   child: const Text('sign in !'))
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
