import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'dart:ui';

// my pages
// import 'pages/welcome_mob.dart';
import 'pages/welcome.dart';
import 'pages/login.dart';
import 'pages/create_profile.dart';
import 'pages/feeds.dart';

void main() {
  // debugPaintSizeEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UniVerseApp',
      initialRoute: '/login',
      routes: {
        '/login': (context) => const Login(),
        '/create-profile': (context) => const CreateProfile(),
        '/feeds': (context) => const Feeds()
        // '/login': (context) => LoginScreen()
      },
    );
  }
}
