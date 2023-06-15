import 'package:chat_app/pages/ResetPassword.dart';
import 'package:chat_app/pages/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../model/BottomNavigationBar.dart';
import '../model/CustomTextfield.dart';
import '../model/SnackBar.dart';
import '../model/customButton.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  bool visibility = true;
  Sign() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: SpinKitFadingCircle(
              color: Color.fromARGB(255, 57, 79, 98),
              size: 160.0,
            ),
          );
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email_controller.text,
        password: password_controller.text,
      );
      showSnackBar(context, "successful");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, "incorrect Email");
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, "incorrect password");
      } else {
        showSnackBar(context, e.code);
      }
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    email_controller.dispose();
    password_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2B475E),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Image.asset("assets/images/scholar.png"),
            ),
            Text(
              "Scholar Chat",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontFamily: "pacifico",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            CustomTExtField(
              autovalidateMode: AutovalidateMode.disabled,
              controller: email_controller,
              validator: (p0) {
                return null;
              },
              lableText: "Enter Your Email",
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.email_sharp,
                  color: Colors.white,
                ),
              ),
            ),
            CustomTExtField(
              autovalidateMode: AutovalidateMode.disabled,
              controller: password_controller,
              validator: (p0) {
                return null;
              },
              lableText: "Enter Your Password",
              obscureText: visibility,
              keyboardType: TextInputType.text,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    if (visibility == true) {
                      visibility = false;
                    } else {
                      visibility = true;
                    }
                  });
                },
                icon: visibility
                    ? Icon(
                        Icons.visibility,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.visibility_off,
                        color: Colors.white,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPassword(),
                        ),
                      );
                    },
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                        color: Color(0xffC7EDE6),
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomButton(
              buttonTitle: "Login",
              onTap: () async {
                await Sign();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomBar(),
                    ));
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "don't have an account? ",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(),
                      ),
                    );
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xffC7EDE6),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
