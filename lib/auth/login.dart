import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project1/Components/CustomButtonAuth.dart';
import 'package:project1/Components/textformfeild.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey();

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
  }

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
                  "Login",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Login To Continue Using The App",
                  style: TextStyle(color: Colors.grey),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 15),
                  child: const Text(
                    "Email",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  margin: const EdgeInsets.only(top: 20, bottom: 15),
                  child: const Text(
                    "Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  margin: const EdgeInsets.only(top: 10, bottom: 20),
                  alignment: Alignment.centerRight,
                  child: const Text(
                    "Forget Password ?",
                    textAlign: TextAlign.right,
                    style: TextStyle(),
                  ),
                ),
                CustomButtonAuth(
                  title: "Login",
                  onPressed: () async {
                    if (formState.currentState!.validate()) {
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email.text, password: password.text);
                        FirebaseAuth.instance.currentUser!
                            .sendEmailVerification();
                        if (credential.user!.emailVerified) {
                          Navigator.of(context).pushReplacementNamed("home");
                        } else {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.rightSlide,
                            title: 'Dialog Title',
                            desc: 'please verifiy your email.',
                          ).show();
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          // print('No user found for that email.');
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Dialog Title',
                            desc: 'No user found for that email.',
                          ).show();
                        } else if (e.code == 'wrong-password') {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            title: 'Error Title',
                            desc: 'Wrong password provided for that user.',
                          ).show();
                        }
                      }
                    } else {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error Title',
                        desc: 'Not valide',
                      ).show();
                    }
                  },
                ),
                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 10, bottom: 15),
                    child: const Text("Or Login With")),
              ],
            ),
          ),
          MaterialButton(
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.red[700],
              textColor: Colors.white,
              onPressed: () {
                signInWithGoogle();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Login With Google  "),
                  Image.asset(
                    "images/4.png",
                    width: 20,
                  )
                ],
              )),
          Container(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacementNamed("signup");
            },
            child: const Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Don't Have An Account ? ",
                ),
                TextSpan(
                    mouseCursor: SystemMouseCursors.help,
                    text: "Register",
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
