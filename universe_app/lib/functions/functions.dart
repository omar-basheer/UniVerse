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
  // print('from function: ' + studentid);
  // print('from function: ' + password);

  var request = http.Request('POST', Uri.parse(url));
  request.body = json.encode({"id": studentid, "password": password});
  request.headers.addAll(headers);
  print('making request....');
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(response.statusCode);
    final apiResponse = json.decode(await response.stream.bytesToString());
    print('final resp: ' + apiResponse.toString());

    if (apiResponse.containsKey('success') && apiResponse['success'] == 'true') {
      // print(await response.stream.bytesToString());
      print('logged user ');
      Navigator.pushNamed(context, '/feeds');
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Status'),
            content: Text(apiResponse['message']),
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
  }
}


Future<void> createProfile(BuildContext context, String studentid, String firstname, String lastname, String email,
    String password, String major, String year, String birthday, String residence, String food, String movie) async {
  String url = 'http://127.0.0.1:5000/create-profile';

  var request = http.Request('POST', Uri.parse(url));
  // request.body = json.encode({"id": studentid, "password": password});

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

  if (response.statusCode == 200) {
    print(response.statusCode);
    final apiResponse = json.decode(await response.stream.bytesToString());
    print(apiResponse['message']);
    print(apiResponse['success']);

    if (apiResponse['success'].toString() == 'true') {
      print('profile created');
      Navigator.pushNamed(context, '/login');
    }
  } else {
    final apiResponse = json.decode(await response.stream.bytesToString());
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Profile Creation Status:'),
          content: Text(apiResponse['message']),
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
}
