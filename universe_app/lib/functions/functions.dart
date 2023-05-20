// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
// import 'package:universe_app/pages/create_profile.dart';
import 'package:universe_app/pages/edit_profile2.dart';
import 'package:universe_app/pages/feeds.dart';
import 'package:universe_app/pages/my_posts.dart';
import 'package:universe_app/pages/view_profile.dart';
import 'package:universe_app/providers/profile_provider.dart';
import '../pages/login.dart';
import '../preferences/dark_mode_service.dart';
import '../providers/user_provider.dart';

// my providers
// UserProvider userProvider = Provider.of<UserProvider>(context as BuildContext);

var headers = {'Content-Type': 'application/json'};

// Login function
Future<void> loginUser(BuildContext context, String studentid, String password) async {
  // String url = 'http://0.0.0.0:8080/login';
  String url = 'https://universeapp-4bb24.nw.r.appspot.com/login';

  if (studentid == null || studentid.trim().isEmpty) {
    // ignore: use_build_context_synchronously
    showCustomDialog(context, 'Error', 'Enter a valid student Id');
    return;
  }

  if (password == null || password.trim().isEmpty) {
    // ignore: use_build_context_synchronously
    showCustomDialog(context, 'Error', 'Enter a valid password');
    return;
  }

  var request = http.Request('POST', Uri.parse(url));
  request.body = json.encode({"id": studentid, "password": password});
  request.headers.addAll(headers);
  print('making request....');
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(response.statusCode);
    final logResponse = json.decode(await response.stream.bytesToString());
    if (logResponse.containsKey('success') && logResponse['success'] == true) {
      // ignore: use_build_context_synchronously
      // Navigator.pushNamed(context, '/feeds');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Feeds(),
        ),
      );

      // setting provider variables
      Provider.of<UserProvider>(context, listen: false).loggedStudentId = studentid;
      print(studentid + ' is logged in');

      String name = logResponse['fname'] + '.' + logResponse['lname'];
      Provider.of<UserProvider>(context, listen: false).loggedStudentname = name;

      String mail = logResponse['email'];
      print(mail);
      Provider.of<UserProvider>(context, listen: false).loggedStudentmail = mail;
    } else {
      // ignore: use_build_context_synchronously
      showCustomDialog(context, 'Login Failed', logResponse['message']);
    }
  }
}

Future<void> createProfile(BuildContext context, String studentid, String firstname, String lastname, String email,
    String password, String major, String year, String birthday, String residence, String food, String movie) async {
  // String url = 'http://0.0.0.0:8080/create-profile';
  String url = 'https://universeapp-4bb24.nw.r.appspot.com/create-profile';

  var request = http.Request('POST', Uri.parse(url));

  request.body = json.encode({
    "id": studentid,
    "this_student": {
      "id_number": studentid,
      "first_name": firstname,
      "last_name": lastname,
      "email": email,
      "DOB": birthday,
      "year": year,
      "major": major,
      "residence": residence,
      "best_food": food,
      "best_movie": movie,
    },
    "password": password,
  });

  request.headers.addAll(headers);
  print('making request....');
  http.StreamedResponse response = await request.send();
  final profileResponse = json.decode(await response.stream.bytesToString());

  if (response.statusCode == 200) {
    print(response.statusCode);
    if (profileResponse.containsKey('success') && profileResponse['success'] == true) {
      print('profile created');
      // ignore: use_build_context_synchronously
      // Navigator.pushNamed(context, '/login');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      showCustomDialog(context, 'Profile Creation Error:', profileResponse['message']);
    }
  } else {
    final profileResponse = json.decode(await response.stream.bytesToString());
    // ignore: use_build_context_synchronously
    showCustomDialog(context, 'Profile Creation Error:', profileResponse['message']);
  }
}

Future<Map<String, dynamic>> getProfile(String studentid) async {
  // String url = 'http://0.0.0.0:8080/view-profile?id=' + studentid;
  String url = 'https://universeapp-4bb24.nw.r.appspot.com/view-profile?id=' + studentid;
  var request = http.Request('GET', Uri.parse(url));
  request.headers.addAll(headers);

  print('making request....');
  http.StreamedResponse response = await request.send();
  final viewResponse = json.decode(await response.stream.bytesToString());
  // print(viewResponse.toString());
  Map<String, dynamic> info = {};
  if (response.statusCode != 200) {
    print(response.statusCode);
  } else {
    if (viewResponse['success'] == true) {
      print('set info1');
      info = viewResponse['info'];
    }
  }
  return info;
}

Future<Map<String, dynamic>> viewProfile(String messagetime) async {
  // String url = 'http://0.0.0.0:8080/feeds?timestamp=' + messagetime;
  String url = 'https://universeapp-4bb24.nw.r.appspot.com/feeds?timestamp=' + messagetime;
  var request = http.Request('GET', Uri.parse(url));
  print('making request 1....');
  http.StreamedResponse response = await request.send();
  final viewResponse = json.decode(await response.stream.bytesToString());

  if (response.statusCode == 200) {
    // print(viewResponse);
  }

  return viewResponse;
}

Future<void> editProfile(BuildContext context, String studentid, String major, String year, String birthday,
    String residence, String food, String movie) async {
  // first get old info from db
  // String url = 'http://0.0.0.0:8080/edit-profile?id=' + studentid;
  String url = 'https://universeapp-4bb24.nw.r.appspot.com/edit-profile?id=' + studentid;
  var request = http.Request('PATCH', Uri.parse(url));

  request.body = json.encode(
      {"DOB": birthday, "year": year, "major": major, "residence": residence, "best_food": food, "best_movie": movie});
  request.headers.addAll(headers);

  print('making request....');
  http.StreamedResponse response = await request.send();
  final editResponse = json.decode(await response.stream.bytesToString());
  // print(editResponse.toString());

  if (response.statusCode == 200) {
    print(response.statusCode);
    if (editResponse.containsKey('success') && editResponse['success'] == true) {
      print('updated');
      // ignore: use_build_context_synchronously
      showCustomNavDialog(context, 'Proflie Updated!', 'yay?!', '/feeds');
      // Navigator.pushNamed(context, '/feeds');
    }
  } else {
    // ignore: use_build_context_synchronously
    showCustomDialog(context, 'Error:', 'Profile couldn\'t update hmm....');
  }
}

// get all feeds for a single user
// Future<List<dynamic>> getUserFeeds() async {
//   String url = 'http://127.0.0.1:5000/feeds';
//   var request = http.Request('GET', Uri.parse(url));
//   request.headers.addAll(headers);
//   print('making request....');
//   http.StreamedResponse response = await request.send();
//   final feedResponse = json.decode(await response.stream.bytesToString());

//   if (response.statusCode == 200) {
//     print(response.statusCode);
//     // print(json.encode(feedResponse));
//   }
//   return feedResponse;
// }

Future<void> createPost(BuildContext context, String studentid, String postMessage) async {
  // String url = 'http://0.0.0.0:8080/create-post';
  String url = 'https://universeapp-4bb24.nw.r.appspot.com/create-post';
  var request = http.Request('PATCH', Uri.parse(url));
  request.headers.addAll(headers);
  request.body = json.encode({"id": studentid, "message": postMessage});
  print('making request....');
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    print('created post');
  } else {
    print('post not created');
  }
}

// single user feed for other users
genSingleFeed(BuildContext context, String email, String message, String time) {
  // message box
  bool isDark = DarkModeService.getDarkMode();
  return Padding(
    padding: const EdgeInsets.only(top: 40, right: 30),
    child: Container(
      width: 850,
      height: 155,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        color: isDark? feedDark : feedLight,
        boxShadow: [
          BoxShadow(
            color: isDark ? shadowColorDark : shadowColorLight,
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      // message box contents
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        child: Container(
          // color: Colors.amberAccent,
          child: Column(children: [
            Container(
              // color: Colors.blueGrey,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // user image avatar
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(195, 195, 195, 1),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 10),
                          child: GestureDetector(
                            onTap: () {
                              print('tapped');
                              Provider.of<ProfileProvider>(context, listen: false).profileMail = email;
                              // print(Provider.of<ProfileProvider>(context, listen: false).profileMail);
                              Provider.of<ProfileProvider>(context, listen: false).messageTime = time;
                              // print(Provider.of<ProfileProvider>(context, listen: false).messageTime);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ViewProfile(),
                                ),
                              );
                            },
                            child: Text(
                              email,
                              style:  TextStyle(
                                  color: isDark? textColorDark : Color.fromARGB(255, 105, 105, 105), fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 500, bottom: 15),
                      child: Text(
                        time,
                        style:  TextStyle(
                            color: isDark? feedTextDark : feedTextLight,
                            fontSize: 10, fontWeight: FontWeight.w300),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          message,
                          // overflow: TextOverflow.clip,
                          textAlign: TextAlign.left,
                          style:  TextStyle(
                              color: isDark? feedTextDark : feedTextLight,
                              fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row()
          ]),
        ),
      ),
    ),
  );
}

// single user feed for logged in user
genLoggedFeed(BuildContext context, String email, String message, String time) {
  // message box
  return Padding(
    padding: const EdgeInsets.only(top: 40, right: 30),
    child: Container(
      width: 850,
      height: 155,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(0),
        ),
        color: const Color.fromARGB(255, 10, 151, 252),
        // color: const Color.fromARGB(255, 132, 94, 194),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 98, 98, 98).withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(1, 3),
          ),
        ],
      ),
      // message box contents
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        child: Container(
          // color: Colors.amberAccent,
          child: Column(children: [
            Container(
              // color: Colors.blueGrey,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // user image avatar
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(195, 195, 195, 1),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 10),
                          child: Text(
                            email,
                            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 500, bottom: 15),
                      child: Text(time,
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w300)),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          message,
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row()
          ]),
        ),
      ),
    ),
  );
}

// alert dialog boxes
void showCustomDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      );
    },
  );
}

void showCustomNavDialog(BuildContext context, String title, String message, String path) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('ok'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, path);
            },
          )
        ],
      );
    },
  );
}

showSideMenubar(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(bottom: 20),
    width: 180,
    height: 350,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: const Color.fromARGB(255, 10, 151, 252),
      // color: const Color.fromARGB(255, 132, 94, 194),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 98, 98, 98).withOpacity(0.5),
          spreadRadius: 0,
          blurRadius: 2,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 20, left: 34, right: 0, bottom: 0),
      // menu items
      child: Container(
        child: Column(
          children: [
            // single button starts here
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, '/view-profile');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Feeds(),
                  ),
                );
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.home,
                    size: 30,
                    color: Color.fromARGB(255, 245, 245, 245),
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Home',
                    style:
                        TextStyle(color: Color.fromARGB(255, 245, 245, 245), fontSize: 15, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            // single button ends here

            // single button starts here
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, '/feeds');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Feeds(),
                  ),
                );
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.question_answer,
                    size: 30,
                    color: Color.fromARGB(255, 245, 245, 245),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Feeds',
                    style:
                        TextStyle(color: Color.fromARGB(255, 245, 245, 245), fontSize: 15, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            // single button ends here

            // single button starts here
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, '/my-posts');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyPosts(),
                  ),
                );
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.bookmark,
                    size: 30,
                    color: Color.fromARGB(255, 245, 245, 245),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'My Posts',
                    style:
                        TextStyle(color: Color.fromARGB(255, 245, 245, 245), fontSize: 15, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            // single button ends here

            // single button starts here
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, '/edit-profile');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProf(),
                  ),
                );
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.people,
                    size: 30,
                    color: Color.fromARGB(255, 245, 245, 245),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Profile',
                    style:
                        TextStyle(color: Color.fromARGB(255, 245, 245, 245), fontSize: 15, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            // single button ends here

            // single button starts here
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () {
                Provider.of<UserProvider>(context, listen: false).loggedStudentmail = '';
                Provider.of<UserProvider>(context, listen: false).loggedStudentname = '';
                Provider.of<UserProvider>(context, listen: false).loggedStudentId = '';
                Provider.of<UserProvider>(context, listen: false).loggedresidence = '';
                Provider.of<UserProvider>(context, listen: false).loggedmajor = '';

                // Navigator.restorablePushNamedAndRemoveUntil(context, '/login', (route) => false);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                  (route) => false,
                );
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.logout,
                    size: 30,
                    color: Color.fromARGB(255, 245, 245, 245),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'LogOut',
                    style:
                        TextStyle(color: Color.fromARGB(255, 245, 245, 245), fontSize: 15, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
            // single button ends here
          ],
        ),
      ),
    ),
  );
}

Future<void> searchUser(BuildContext context, String profmail) async {
  CollectionReference profiles = FirebaseFirestore.instance.collection('profiles');
  QuerySnapshot mail = await profiles.where('this_student.email', isEqualTo: profmail).get();
  if (mail.docs.isNotEmpty) {
    DocumentSnapshot documentSnapshot = mail.docs.first;
    Map<String, dynamic> documentData = documentSnapshot.data() as Map<String, dynamic>;
    // process the documentData as needed
    Provider.of<ProfileProvider>(context, listen: false).profileId = documentData['id'];
    print(Provider.of<ProfileProvider>(context, listen: false).profileId);
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ViewProfile(),
      ),
    );
  } else {
    // handle case where no document with the specified field value is found
    // ignore: use_build_context_synchronously
    showCustomDialog(context, 'Oops....', 'looks like that user doesn\'t exist....');
  }
}

genSearchBar(BuildContext context) {
  return Expanded(
    flex: 1,
    child: Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 55, left: 16, right: 16),
            child: TextFormField(
              controller: searchbar,
              decoration: InputDecoration(
                labelText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelStyle: const TextStyle(
                  color: Color.fromRGBO(180, 180, 180, 1),
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              onFieldSubmitted: (value) {
                String email = searchbar.text;
                searchUser(context, email);
              },
            ),
          ),
        ),
      ),
    ),
  );
}

class User {
  late final String email;
  late final String name;

  User({required this.email, required this.name});

  int compareTo(User other) {
    return email.compareTo(other.email);
  }
}

genSearch(BuildContext context) {
  List<User> users = [];
  bool isLoading = true;
  bool isDark = DarkModeService.getDarkMode();

  Future<void> fetchUsers() async {
    String url = 'http://127.0.0.1:5000/get-profiles';
    var request = http.Request('GET', Uri.parse(url));
    print('getting users...');
    http.StreamedResponse response = await request.send();
    final getResponse = json.decode(await response.stream.bytesToString());
    // print(getResponse);

    for (var user in getResponse) {
      String email = user['email'].toString();
      String name = user['name'].toString();
      users.add(User(email: email, name: name));
    }
    // print(users.toString());
  }

  fetchUsers();
  // fetchUsers().then((_) {
  //   setState(() {
  //     isLoading = false;
  //   });
  // });

  GlobalKey<AutoCompleteTextFieldState<User>> searchKey = GlobalKey();

  return Expanded(
    flex: 1,
    child: Container(
      color: isDark ? searchColorDark : backgroundColorLight,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            color: isDark ? searchColorDark : backgroundColorLight,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 55, left: 16, right: 16),
            child: AutoCompleteTextField<User>(
              key: searchKey,
              controller: searchbar,
              suggestions: users,
              clearOnSubmit: false,
              decoration: InputDecoration(
                labelText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelStyle: TextStyle(
                  color: isDark ? textColorDark : textColorLight,
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              itemFilter: (item, query) {
                final user = item;
                return user.email.toLowerCase().contains(query.toLowerCase()) ||
                    user.name.toLowerCase().contains(query.toLowerCase());
              },
              itemSorter: (a, b) {
                return a.compareTo(b);
              },
              itemSubmitted: (value) {
                String email = value.email;
                print(email);
                searchbar.text = email;
                searchUser(context, email);
              },
              itemBuilder: (context, item) {
                final user = item;
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color.fromRGBO(180, 180, 180, 1),
                    child: Icon(Icons.person),
                  ),
                  title: Text(user.email),
                  subtitle: Text(user.name),
                );
              },
            ),
          ),
        ),
      ),
    ),
  );
}
