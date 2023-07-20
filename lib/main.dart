import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tikipap/LoginPage.dart';
import 'firebase_options.dart';
import 'app/modules/views/landingPage/landing_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Chit-Chat',
        debugShowCheckedModeBanner: false,
        scrollBehavior: ScrollBehavior().copyWith(overscroll: false),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return LandingPage();
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Sorry Some error Occured please try again"),
              );
            } else {
              return LoginPage();
            }
          },
        ));
  }
}
