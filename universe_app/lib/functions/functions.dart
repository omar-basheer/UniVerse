import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

// my providers

// UserProvider userProvider = Provider.of<UserProvider>(context as BuildContext);
// Login function
Future<void> loginUser(BuildContext context,String studentid, String password) async {
  String url = 'http://127.0.0.1:5000/login';

  // request body
  Map<String, String> body = {'id': studentid, 'password': password};

  // make request for login
  http.Response response = await http.post(Uri.parse(url), body: body);

  if (response.statusCode == 200) {
    print('logged in user:' + studentid);
    print(response.body);
    
    Navigator.pushNamed(context , '/feeds');
  } else {
    print('login failed');
    print(response.body);
  }
}

// Login status function
