import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/UserDataFromFireStore.dart';

class profilePage extends StatelessWidget {
  const profilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Color(0xff2B475E),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetUserData(
              documentId: user!.uid,
            ),
          ],
        ),
      ),
    );
  }
}
