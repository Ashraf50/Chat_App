import 'package:chat_app/bloc/Authbloc/auth_bloc.dart';
import 'package:chat_app/pages/SignIn.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../model/CustomTextfield.dart';
import '../model/SnackBar.dart';
import '../model/customButton.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignInState();
}

class _SignInState extends State<SignUp> {
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final userName_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool visibility = true;

  @override
  void dispose() {
    super.dispose();
    password_controller.dispose();
    email_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          Center(
            child: SpinKitFadingCircle(
              color: Color.fromARGB(255, 57, 79, 98),
              size: 160.0,
            ),
          );
        }
        if (state is RegisterSuccess) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignIn(),
              ));
        } else if (state is RegisterFailure) {
          showSnackBar(context, state.MassageError);
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: Color(0xff2B475E),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                          "Register",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                CustomTextfield(
                  validator: (p0) {
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.disabled,
                  controller: userName_controller,
                  labelText: "Enter Username",
                  obscureText: false,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 27,
                    ),
                  ),
                ),
                CustomTextfield(
                  validator: (value) {
                    return value != null && !EmailValidator.validate(value)
                        ? "Enter a valid email"
                        : null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: email_controller,
                  labelText: "Enter Your Email",
                  obscureText: false,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.email_sharp,
                      color: Colors.white,
                    ),
                  ),
                ),
                CustomTextfield(
                  validator: (value) {
                    return value!.length < 6
                        ? "Enter at least 6 character"
                        : null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: password_controller,
                  labelText: "Enter Your Password",
                  obscureText: visibility,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        visibility = !visibility;
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
                CustomButton(
                  buttonTitle: "Register",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<AuthBloc>(context).add(RegisterEvent(
                        Username: userName_controller.text,
                        email: email_controller.text,
                        password: password_controller.text,
                      ));
                    } else {
                      showSnackBar(context, "check the email or password");
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "do you have an account? ",
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
                            builder: (context) => SignIn(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign In",
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
        ),
      ),
    );
  }
}
