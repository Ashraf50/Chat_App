import 'package:chat_app/pages/ChatPage.dart';
import 'package:chat_app/pages/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'model/BottomNavigationBar.dart';
import 'model/SnackBar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "ChatPage":(context) => ChatPage(),
      },
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 181, 180, 180),
              ),
            );
          } else if (snapshot.hasError) {
            return showSnackBar(context, "Something went wrong");
          } else if (snapshot.hasData) {
            return BottomBar();
          } else {
            return Home();
          }
        },
      ),
    );
  }
}
