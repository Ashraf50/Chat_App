import 'package:chat_app/pages/SignIn.dart';
import 'package:chat_app/pages/SignUp.dart';
import 'package:flutter/material.dart';

import '../model/customButton.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff2B475E),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Text(
                  "Hello",
                  style: TextStyle(
                    fontSize: 100,
                    fontFamily: "Pacifico",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Column(
              children: [
                CustomButton(
                  buttonTitle: "Login",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignIn(),
                        ));
                  },
                ),
                CustomButton(
                  buttonTitle: "Register",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUp(),
                        ));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
