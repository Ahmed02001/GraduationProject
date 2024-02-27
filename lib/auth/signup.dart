import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project1/Components/CustomButtonAuth.dart';
import 'package:project1/Components/textformfeild.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 80,
                    width: 80,
                    margin: const EdgeInsets.only(top: 50, bottom: 20),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(100)),
                    child: Image.asset(
                      "images/logo2.png",
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
                const Text(
                  "Register",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Login To Continue Using The App",
                  style: TextStyle(color: Colors.grey),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15, bottom: 10),
                  child: const Text(
                    "Username",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                CustomTextForm(
                  hintText: "Enter Your Username",
                  MyController: username,
                  validator: (val) {
                    if (val == "") {
                      return "Can't to be empty";
                    }
                    return null;
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15, bottom: 10),
                  child: const Text(
                    "Email",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                CustomTextForm(
                  hintText: "Enter Your Email",
                  MyController: email,
                  validator: (val) {
                    if (val == "") {
                      return "Can't to be empty";
                    }
                    return null;
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15, bottom: 10),
                  child: const Text(
                    "Password",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                CustomTextForm(
                  hintText: "Enter Your Password",
                  MyController: password,
                  validator: (val) {
                    if (val == "") {
                      return "Can't to be empty";
                    }
                    return null;
                  },
                ),

                Container(
                  height: 20,
                ),
                // MaterialButton(
                //   minWidth: 500,
                //   padding: const EdgeInsets.all(10),
                //   color: Colors.blue,
                //   textColor: Colors.white,
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(50)),
                //   onPressed: () {},
                //   child: const Text(
                //     "Register",
                //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                //   ),
                // ),
              ],
            ),
          ),
          Container(height: 10),
          CustomButtonAuth(
              title: "SignUp",
              onPressed: () async {
                if (formState.currentState!.validate()) {
                  try {
                    // ignore: unused_local_variable
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email.text,
                      password: password.text,
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacementNamed("login");
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                } else {
                  print("Error");
                }
              }),
          Container(height: 10),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("login");
            },
            child: const Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Do You Have An Account ? ",
                ),
                TextSpan(
                    text: "Login",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold)),
              ])),
            ),
          )
        ],
      ),
    );
  }
}
