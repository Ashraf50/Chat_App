import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTExtField extends StatelessWidget {
  TextInputType keyboardType;
  String lableText;
  bool obscureText;
  IconButton suffixIcon;
  String? Function(String?) validator;
  TextEditingController controller;
  AutovalidateMode autovalidateMode;
  CustomTExtField(
      {required this.keyboardType,
      required this.lableText,
      required this.obscureText,
      required this.suffixIcon,
      required this.validator,
      required this.controller,
      required this.autovalidateMode,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        style: TextStyle(color: Colors.white,fontSize: 17),
        autovalidateMode: autovalidateMode,
        controller: controller,
        validator: validator ,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          labelText: lableText,
          labelStyle: TextStyle(color: Colors.white),
          filled: true,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
