import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String loggedStudentId = "";
  String loggedStudentname = "";
  String loggedStudentmail = "";
  String loggedresidence = '';
  String loggedmajor = '';

  String get loggedInStudentId => loggedStudentId;
  String get loggedInStudentname => loggedStudentname;
  String get loggedInStudentmail => loggedStudentmail;
  String get loggedInStudentmajor => loggedmajor;
  String get loggedInStudentresidence => loggedresidence;

  void setLoggedInRes(String residence) {
    loggedresidence = residence;
    notifyListeners();
  }

  void setLoggedInMajor(String major) {
    loggedmajor = major;
    notifyListeners();
  }

  void setLoggedIn(String studentid) {
    loggedStudentId = studentid;
    notifyListeners();
  }

  void setLoggedInName(String name) {
    loggedStudentname = name;
    notifyListeners();
  }

  void setLoggedInMail(String mail) {
    loggedStudentmail = mail;
    notifyListeners();
  }
}
