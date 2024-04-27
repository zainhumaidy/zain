import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:qerscan/amjad/techerauth.dart';
import 'package:qerscan/components/Logo.dart';
import '../components/textform.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class teLogin extends StatefulWidget {
  const teLogin({super.key});

  @override
  State<teLogin> createState() => _teLoginState();
}

class _teLoginState extends State<teLogin> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isLoading = false;

  final controller = Get.put(teAuthService());

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
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, 'Cselect');
          },
          icon: Icon(
            Icons.keyboard_arrow_left,
            size: 42,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.login,
                size: 40,
              ))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 10,
                  ),
                  const Logo(),
                  Container(
                    height: 0.0005,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 5,
                  ),
                  const Text(
                    'Login To Continue..',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Container(
                    height: 20,
                  ),
                  Text(
                    'Email',
                    style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 10,
                  ),
                  CustomTextForm(
                    hinttext: 'Enter Your Email',
                    mycontroller: email,
                    validator: (val) {
                      if (val == "") {
                        return "Can't Be Empty";
                      }
                    },
                  ),
                  Container(
                    height: 5,
                  ),
                  Text(
                    'Password',
                    style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 10,
                  ),
                  CustomTextForm(
                      hinttext: 'Enter Your Password',
                      mycontroller: password,
                      validator: (val) {
                        if (val == "") {
                          return "Can't Be Empty";
                        }
                      }),
                  InkWell(
                    onTap: () async {
                      if (email.text == "") {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.info,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc:
                          'please Put Your Email And Press (Forget PassWord) To Access The App',
                        ).show();

                        return;
                      }
                      try {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: email.text);

                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          animType: AnimType.rightSlide,
                          title: 'info',
                          desc:
                          'please Check Your Email And Reset PassWord To Access The App',
                        ).show();
                      } catch (e) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: 'Wrong Email Try Again',
                        ).show();
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      alignment: Alignment.topRight,
                      child: const Text(
                        'Forget Password ?',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStatePropertyAll(Colors.lightBlue.shade900)),
                onPressed: () async {
                  controller.signInWithEmailAndPassword(
                      email.text, password.text);
                  setState(() {});
                },
                child: controller.isLoading == true
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : const Text(
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    'Login'),
              ),
            ),
            Container(
              height: 10,
            ),
            const Center(child: Text('Or Login With')),
            const SizedBox(
              height: 5,
            ),
            MaterialButton(
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.lightBlue.shade900,
              onPressed: () {
                signInWithGoogle();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Google',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    width: 15,
                  ),
                  Container(
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          "images/Go.jpg",
                          width: 27,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            MaterialButton(
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.lightBlue.shade900,
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Facebook',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    width: 15,
                  ),
                  Container(
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          "images/fa.jpg",
                          width: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("teSignup");
              },
              child: Center(
                child: Text.rich(TextSpan(children: [
                  const TextSpan(
                    text: "Don't Have An Account ? ",
                  ),
                  TextSpan(
                      text: "Register",
                      style: TextStyle(
                          color: Colors.amber.shade900,
                          fontWeight: FontWeight.bold)),
                ])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
