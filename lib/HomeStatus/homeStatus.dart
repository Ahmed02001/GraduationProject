import 'package:flutter/material.dart';

class homeStatus extends StatefulWidget {
  const homeStatus({super.key});

  @override
  State<homeStatus> createState() => _MyhomeStatusState();
}

class _MyhomeStatusState extends State<homeStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Status")),
      body: Container(color: Colors.amber),
    );
  }
}
