import 'package:chat_app/model/CustomTextfield.dart';
import 'package:chat_app/model/SnackBar.dart';
import 'package:chat_app/model/customButton.dart';
import 'package:chat_app/pages/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final email_controller = TextEditingController();
    Reset_pass() async {
      showDialog(
          context: context,
          builder: (context) {
            return SpinKitFadingCircle(
              color: Color.fromARGB(146, 12, 16, 49),
              size: 160.0,
            );
          });
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: email_controller.text,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SignIn(),
          ),
        );
        showSnackBar(context, "check the email");
      } on FirebaseAuthException catch (e) {
        showSnackBar(context, "${e.code}");
        Navigator.pop(context);
      }
    }

    return Scaffold(
      backgroundColor: Color(0xff2B475E),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTExtField(
              keyboardType: TextInputType.emailAddress,
              lableText: "Enter Your Email",
              obscureText: false,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
              ),
              validator: (p0) {
                return null;
              },
              controller: email_controller,
              autovalidateMode: AutovalidateMode.disabled),
          SizedBox(
            height: 20,
          ),
          CustomButton(
            buttonTitle: "Reset",
            onTap: () async {
              await Reset_pass();
            },
          )
        ],
      ),
    );
  }
}
