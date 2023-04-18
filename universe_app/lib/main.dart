import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:universe_app/providers/user_provider.dart';
import 'dart:async';
import 'dart:ui';

// my pages
// import 'pages/welcome_mob.dart';
import 'pages/welcome.dart';
import 'pages/login.dart';
import 'pages/create_profile.dart';
import 'pages/feeds.dart';
import 'pages/edit_profile.dart';

// my providers

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (_) => UserProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UniVerseApp',
        // initialRoute: '/login',
        initialRoute: '/create-profile',
        routes: {
          '/login': (context) => const Login(),
          '/create-profile': (context) => const CreateProfile(),
          '/feeds': (context) => const Feeds(),
          '/edit-profile': (context) => const EditProfile()
        },
      ),
    );
  }
}
