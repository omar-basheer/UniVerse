import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Use MultiProvider to provide multiple providers
      providers: [
        ChangeNotifierProvider<UserProvider>(
          // UserProvider
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider<ProfileProvider>(
          // ProfileProvider
          create: (_) => ProfileProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UniVerseApp',
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
