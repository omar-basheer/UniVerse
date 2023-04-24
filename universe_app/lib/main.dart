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
        apiKey: "AIzaSyChfOm__qdWlcFr21bCqgThxzywttQkRh0",
        authDomain: "my-cloud-api-382615.firebaseapp.com",
        projectId: "my-cloud-api-382615",
        storageBucket: "my-cloud-api-382615.appspot.com",
        messagingSenderId: "79292440772",
        appId: "1:79292440772:web:b796a0acc33320d44a2991",
        measurementId: "G-6SQ6N3FLTV"),
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
