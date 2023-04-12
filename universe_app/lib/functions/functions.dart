// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
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
    print('user ' + studentid + 'logged in successfully');
    print(await response.stream.bytesToString());
  } else {
    print('failed to create user:  {$response.body}');
    print(response.reasonPhrase);
  }
}

Future<void> createProfile(BuildContext context, String studentid, String firstname, String lastname, String email,
    String password, String major, String year, String residence, String food, String movie) async {
  String url = 'http://127.0.0.1:5000/create-profile';

  var request = http.Request('POST', Uri.parse(url));

  Map<String, dynamic> data = {
    "id": "14042024",
    "this_student": {
      "id_number": "14042024",
      "first_name": "abigail",
      "last_name": "basheer",
      "email": "abby@ashesi.edu.gh",
      "DOB": "12/05/2002",
      "year": "2024",
      "major": "Computer Science",
      "residence": "Off-Campus",
      "best_food": "jollof",
      "best_movie": "we were once a fairytale"
    },
    "password": "somePass4"
  };

  request.body = json.encode(data);
  request.headers.addAll(headers);
  print('making request....');
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print('user profile for ' + studentid + 'created successfully');
    print(await response.stream.bytesToString());
  } else {
    print('failed to create user:  {$response.body}');
    print(response.reasonPhrase);
  }

}
