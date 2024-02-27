import 'package:flutter/material.dart';

class CustomButtonAuth extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const CustomButtonAuth({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
      minWidth: 500,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.blue,
      textColor: Colors.white,
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
