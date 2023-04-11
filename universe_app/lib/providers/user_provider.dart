import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  bool isLoggedIn = false;

  bool get userStatus => isLoggedIn;

  void setLoggedIn(bool value) {
    isLoggedIn = value;
    notifyListeners();
  }
}
