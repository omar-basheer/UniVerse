import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
String loggedStudentId = "";
String loggedStudentname = "";
String loggedStudentmail = "";

 String get loggedInStudentId => loggedStudentId;
 String get loggedInStudentname => loggedStudentname;
 String get loggedInStudentmail => loggedStudentmail;

  void setLoggedIn(String studentid) {
    loggedStudentId = studentid;
    notifyListeners();
  }

    void setLoggedInName(String name) {
    loggedStudentname = name;
    notifyListeners();
  }

      void setLoggedInMail(String mail) {
    loggedStudentname = mail;
    notifyListeners();
  }
}
