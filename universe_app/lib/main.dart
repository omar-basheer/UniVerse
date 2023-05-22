import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universe_app/preferences/dark_mode_service.dart';
import 'package:universe_app/providers/profile_provider.dart';
import 'package:universe_app/providers/user_provider.dart';
import 'dart:async';
import 'dart:ui';

// my pages
// import 'pages/welcome_mob.dart';
import 'pages/welcome.dart';
import 'pages/login.dart';
import 'pages/create_profile.dart';
import 'pages/feeds.dart';
import 'pages/view_profile.dart';
import 'pages/edit_profile2.dart';
import 'pages/my_posts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DarkModeService.initDarkPreference();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAumQO1Zjzz2AzwOPqWNhzkkszoYpAjvdc",
        authDomain: "universeapp-4bb24.firebaseapp.com",
        projectId: "universeapp-4bb24",
        storageBucket: "universeapp-4bb24.appspot.com",
        messagingSenderId: "589132354665",
        appId: "1:589132354665:web:d767cfd7e69fa80e1abef8",
        measurementId: "G-JY8H4JKTK3"),
  );
  runApp(const MyApp());
}

// bool isDark = false;
bool isDark = DarkModeService.getDarkMode();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DarkModeService.setDarkMode(isDark);
    DarkModeService.getDarkMode();

    return MultiProvider(
      // Use MultiProvider to provide multiple providers
      providers: [
        // UserProvider
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),

        // ProfileProvider
        ChangeNotifierProvider<ProfileProvider>(
          create: (_) => ProfileProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UniVerseApp',
        theme: isDark ? ThemeData.dark() : ThemeData.light(),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const Login(),
          '/create-profile': (context) => const CreateProfile(),
          '/feeds': (context) => const Feeds(),
          '/edit-profile': (context) => const EditProf(),
          '/my-posts': (context) => const MyPosts(),
          '/view-profile': (context) => const ViewProfile(),
        },
      ),
    );
  }
}
