import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String labelText;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  const CustomTextfield({
    super.key,
    required this.labelText,
    required this.suffixIcon,
    required this.obscureText,
    required this.controller,
    required this.validator,
    required this.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        validator: validator,
        autovalidateMode: autovalidateMode,
        controller: controller ,
        obscureText: obscureText,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white, fontSize: 18),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white),
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
