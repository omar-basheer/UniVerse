import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String profileMail = '';
  String messageTime = '';
  String profileId = '';

  String get studentProfileMail => profileMail;
  String get feedMessageTime => messageTime;

  String get studentProfileId => profileId;

  void setProfileID(id) {
    profileId = id;
    notifyListeners();
  }

  set feedMessageTime(String time) {
    messageTime = time;
    notifyListeners();
  }

  void setProfileMail(String mail) {
    profileMail = mail;
    notifyListeners();
  }
}
