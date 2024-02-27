import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hintText;

  // ignore: non_constant_identifier_names
  final TextEditingController MyController;

  final String? Function(String?)? validator;

  const CustomTextForm(
      // ignore: non_constant_identifier_names
      {super.key,
      required this.hintText,
      // ignore: non_constant_identifier_names
      required this.MyController,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: MyController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide:
                BorderSide(color: const Color.fromARGB(255, 184, 184, 184))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Colors.grey)),
      ),
    );
  }
}
