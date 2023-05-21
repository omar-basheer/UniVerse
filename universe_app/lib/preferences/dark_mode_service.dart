import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeService {
  static SharedPreferences? _sharedPreferences;

  static Future<void> initDarkPreference() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static bool getDarkMode() {
    return _sharedPreferences?.getBool('darkMode') ?? false;
  }

  static Future<void> setDarkMode(bool value) async {
    await _sharedPreferences?.setBool('darkMode', value);
  }
}

const Color primaryColor = Color.fromRGBO(10, 151, 252, 1);
const Color backgroundColorLight = Color.fromRGBO(245, 244, 244, 1);
const Color backgroundColorDark = Color.fromARGB(255, 27, 27, 27);
const Color foregroundColorLight = Color.fromRGBO(245, 244, 244, 1);
const Color foregroundColorDark = Color.fromARGB(255, 39, 39, 39);
const Color feedBackgroundColorLight = Color.fromRGBO(245, 244, 244, 1);
const Color feedBackgroundColorDark = Color.fromARGB(255, 39, 39, 39);
const Color textErrorLight = Color.fromARGB(212, 185, 185, 185);
const Color textErrorDark = Color.fromRGBO(255, 255, 255, 1);
const Color textColorLight = Color.fromRGBO(99, 99, 99, 1);
const Color textColorDark = Color.fromRGBO(255, 255, 255, 1);
const Color textColorLight2 = Color.fromRGBO(72, 72, 72, 1);
const Color textColorDark2 = Color.fromRGBO(189, 189, 189, 1);
const Color textColorLight3 = Color.fromARGB(255, 85, 85, 85);
const Color textColorDark3 = Color.fromRGBO(235, 235, 235, 1);
const Color textColorLight4 = Color.fromARGB(255, 107, 107, 107);
const Color textColorDark4 = Color.fromRGBO(215, 215, 215, 1);
const Color textColorLight5 = Color.fromARGB(255, 139, 139, 139);
const Color borderColorLight = Color.fromRGBO(245, 244, 244, 1);
const Color borderColorDark = Color.fromRGBO(98, 98, 98, 1);
Color shadowColorLight = Color.fromARGB(255, 98, 98, 98).withOpacity(0.5);
Color shadowColorDark = Color.fromARGB(255, 31, 31, 31);
const Color loggedMailLight = Color.fromRGBO(63, 63, 63, 1);
const Color loggedMailDark = Color.fromRGBO(255, 255, 255, 1);
const Color fillColorLight = Color.fromRGBO(255, 255, 255, 1);
const Color fillColorDark = Color.fromARGB(255, 27, 27, 27);
const Color hoverColorLight = Color.fromRGBO(255, 255, 255, 1);
const Color hoverColorDark = Color.fromRGBO(52, 52, 52, 1);
const Color feedTextLight = Color.fromARGB(255, 39, 39, 39);
const Color feedTextDark = Color.fromARGB(255, 255, 255, 255);
const Color feedLight = Color.fromARGB(255, 255, 255, 255);
const Color feedDark = Color.fromARGB(255, 39, 39, 39);
const Color disabledTextLight = Color.fromARGB(213, 101, 101, 101);
const Color disabledTextDark = Color.fromARGB(212, 130, 130, 130);

final themeData =
    ThemeData(brightness: DarkModeService.getDarkMode() ? Brightness.dark : Brightness.light, fontFamily: 'Montserrat');
