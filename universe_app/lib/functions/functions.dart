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

// single user feed
genSingleFeed(BuildContext context, String text, String message) {
  //single feed starts here
  return Padding(
    padding: const EdgeInsets.only(top: 40),
    child: Container(
      width: 800,
      height: 145,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
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

      // user image avatar
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(245, 244, 244, 1),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
              children: const [
                Text(
                  '@kanye.yeezuswest',
                )
              ],
            ))
          ],
        ),
      ),
    ),
  );
}

// get all feeds for a single user
Future<List<dynamic>> getUserFeeds() async {
  String url = 'http://127.0.0.1:5000/feeds';
  var request = http.Request('GET', Uri.parse(url));
  request.headers.addAll(headers);
  print('making request....');
  http.StreamedResponse response = await request.send();
  final feedResponse = json.decode(await response.stream.bytesToString());
  List<Map> genericMap = [
    {'test': "value"}
  ];
  if (response.statusCode == 200) {
    print(response.statusCode);
    print(json.encode(feedResponse));
  }
  return feedResponse;
}
