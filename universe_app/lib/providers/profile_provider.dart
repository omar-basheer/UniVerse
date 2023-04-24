import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String profileMail = '';
  String messageTime = '';

  String get studentProfileMail => profileMail;
  String get feedMessageTime => messageTime;

  set feedMessageTime(String time) {
    messageTime = time;
    notifyListeners();
  }

  void setProfileMail(String mail) {
    profileMail = mail;
    notifyListeners();
  }
}
