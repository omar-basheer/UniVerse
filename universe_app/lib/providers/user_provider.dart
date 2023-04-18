import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
String loggedStudentId = "";

 String get loggedInStudentId => loggedStudentId;

  void setLoggedIn(String studentid) {
    loggedStudentId = studentid;
    notifyListeners();
  }
}
