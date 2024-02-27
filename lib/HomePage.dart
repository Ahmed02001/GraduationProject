import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project1/HomePage/bodyHome.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("firebase Project"),
        actions: [
          IconButton(
            onPressed: () async {
              // GoogleSignIn googleSignIn = GoogleSignIn();
              // googleSignIn.disconnect();
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("login", (route) => false);
            },
            icon: const Icon(Icons.exit_to_app),
            color: Colors.amber,
          ),
        ],
      ),
      body: ListView(children: [
        // FirebaseAuth.instance.currentUser!.emailVerified
        Container(
          color: Colors.green,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BodyHome()),
              );
            },
            child: Image.asset(
              "images/redCar.png",
              width: 500,
              height: 785,
            ),
          ),
        ),

        // : MaterialButton(
        //     onPressed: () {
        //       FirebaseAuth.instance.currentUser!.sendEmailVerification();
        //     },
        //     color: Colors.green,
        //     child: const Text("verfiy your email"),
        //   )
      ]),
    );
  }
}
