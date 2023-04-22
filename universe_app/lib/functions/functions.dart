// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:universe_app/pages/create_profile.dart';
import '../providers/user_provider.dart';

// my providers
// UserProvider userProvider = Provider.of<UserProvider>(context as BuildContext);

var headers = {'Content-Type': 'application/json'};

// Login function
Future<void> loginUser(BuildContext context, String studentid, String password) async {
  String url = 'http://127.0.0.1:5000/login';

  if (studentid == null || studentid.trim().isEmpty) {
    // ignore: use_build_context_synchronously
    showCustomDialog(context, 'Error', 'Enter a valid student Id');
    return;
  }

  if (password == null || password.trim().isEmpty) {
    // ignore: use_build_context_synchronously
    showCustomDialog(context, 'Error', 'Enter a valid password');
    return;
  }

  var request = http.Request('POST', Uri.parse(url));
  request.body = json.encode({"id": studentid, "password": password});
  request.headers.addAll(headers);
  print('making request....');
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(response.statusCode);
    final logResponse = json.decode(await response.stream.bytesToString());
    if (logResponse.containsKey('success') && logResponse['success'] == true) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/feeds');
      student_id.clear();

      // setting provider variables
      Provider.of<UserProvider>(context, listen: false).loggedStudentId = studentid;
      print(studentid + ' is logged in');

      String name = logResponse['fname'] + '.' + logResponse['lname'];
      Provider.of<UserProvider>(context, listen: false).loggedStudentname = name;

      String mail = logResponse['email'];
      print(mail);
      Provider.of<UserProvider>(context, listen: false).loggedStudentmail = mail;
    } else {
      // ignore: use_build_context_synchronously
      showCustomDialog(context, 'Login Failed', logResponse['message']);
    }
  }
}

Future<void> createProfile(BuildContext context, String studentid, String firstname, String lastname, String email,
    String password, String major, String year, String birthday, String residence, String food, String movie) async {
  String url = 'http://127.0.0.1:5000/create-profile';

  var request = http.Request('POST', Uri.parse(url));

  request.body = json.encode({
    "id": studentid,
    "this_student": {
      "id_number": studentid,
      "first_name": firstname,
      "last_name": lastname,
      "email": email,
      "DOB": birthday,
      "year": year,
      "major": major,
      "residence": residence,
      "best_food": food,
      "best_movie": movie,
    },
    "password": password,
  });

  request.headers.addAll(headers);
  print('making request....');
  http.StreamedResponse response = await request.send();
  final profileResponse = json.decode(await response.stream.bytesToString());

  if (response.statusCode == 200) {
    print(response.statusCode);
    if (profileResponse.containsKey('success') && profileResponse['success'] == true) {
      print('profile created');
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/login');
    } else {
      // ignore: use_build_context_synchronously
      showCustomDialog(context, 'Profile Creation Error:', profileResponse['message']);
    }
  } else {
    final profileResponse = json.decode(await response.stream.bytesToString());
    // ignore: use_build_context_synchronously
    showCustomDialog(context, 'Profile Creation Error:', profileResponse['message']);
  }
}

Future<Map<String, dynamic>> getProfile(String studentid) async {
  String url = 'http://127.0.0.1:5000/view-profile?id=' + studentid;
  var request = http.Request('GET', Uri.parse(url));
  request.headers.addAll(headers);

  print('making request....');
  http.StreamedResponse response = await request.send();
  final viewResponse = json.decode(await response.stream.bytesToString());
  print(viewResponse.toString());
  Map<String, dynamic> info = {};
  if (response.statusCode != 200) {
    print(response.statusCode);
  } else {
    if (viewResponse['success'] == true) {
      print('set info');
      info = viewResponse['info'];
    }
  }
  return info;
}

Future<void> editProfile(BuildContext context, String studentid, String major, String year, String birthday,
    String residence, String food, String movie) async {
  // first get old info from db
  String url = 'http://127.0.0.1:5000/edit-profile?id=' + studentid;
  var request = http.Request('PATCH', Uri.parse(url));

  request.body = json.encode(
      {"DOB": birthday, "year": year, "major": major, "residence": residence, "best_food": food, "best_movie": movie});
  request.headers.addAll(headers);

  print('making request....');
  http.StreamedResponse response = await request.send();
  final editResponse = json.decode(await response.stream.bytesToString());
  print(editResponse.toString());

  if (response.statusCode == 200) {
    print(response.statusCode);
    if (editResponse.containsKey('success') && editResponse['success'] == true) {
      print('updated');
      // ignore: use_build_context_synchronously
      showCustomNavDialog(context, 'Proflie Updated!', '         yay?!', '/feeds');
      // Navigator.pushNamed(context, '/feeds');
    }
  } else {
    // ignore: use_build_context_synchronously
    showCustomDialog(context, 'Error:', 'Profile couldn\'t update hmm....');
  }
}

// get all feeds for a single user
// Future<List<dynamic>> getUserFeeds() async {
//   String url = 'http://127.0.0.1:5000/feeds';
//   var request = http.Request('GET', Uri.parse(url));
//   request.headers.addAll(headers);
//   print('making request....');
//   http.StreamedResponse response = await request.send();
//   final feedResponse = json.decode(await response.stream.bytesToString());

//   if (response.statusCode == 200) {
//     print(response.statusCode);
//     // print(json.encode(feedResponse));
//   }
//   return feedResponse;
// }

Future<void> createPost(BuildContext context, String studentid, String postMessage) async {
  String url = 'http://127.0.0.1:5000/create-post';
  var request = http.Request('PATCH', Uri.parse(url));
  request.headers.addAll(headers);
  request.body = json.encode({"id": studentid, "message": postMessage});
  print('making request....');
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print('created post');
  } else {
    print('post not created');
  }
}

// single user feed for other users
genSingleFeed(BuildContext context, String email, String message, String time) {
  // message box
  return Padding(
    padding: const EdgeInsets.only(top: 40, right: 30),
    child: Container(
      width: 850,
      height: 155,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        color: const Color.fromARGB(255, 255, 255, 255),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 98, 98, 98).withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      // message box contents
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        child: Container(
          // color: Colors.amberAccent,
          child: Column(children: [
            Container(
              // color: Colors.blueGrey,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // user image avatar
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(195, 195, 195, 1),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 10),
                          child: Text(
                            email,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 105, 105, 105), fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 500, bottom: 15),
                      child: Text(time,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 142, 142, 142), fontSize: 10, fontWeight: FontWeight.w300)),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          message,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 142, 142, 142), fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row()
          ]),
        ),
      ),
    ),
  );
}

// single user feed for logged in user
genLoggedFeed(BuildContext context, String email, String message, String time) {
  // message box
  return Padding(
    padding: const EdgeInsets.only(top: 40, right: 30),
    child: Container(
      width: 850,
      height: 155,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(0),
        ),
        color: const Color.fromARGB(255, 132, 94, 194),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 98, 98, 98).withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      // message box contents
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        child: Container(
          // color: Colors.amberAccent,
          child: Column(children: [
            Container(
              // color: Colors.blueGrey,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // user image avatar
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(195, 195, 195, 1),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 10),
                          child: Text(
                            email,
                            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 500, bottom: 15),
                      child: Text(time,
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w300)),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          message,
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row()
          ]),
        ),
      ),
    ),
  );
}

// alert dialog boxes
void showCustomDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}

void showCustomNavDialog(BuildContext context, String title, String message, String path) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('ok'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, path);
            },
          )
        ],
      );
    },
  );
}
