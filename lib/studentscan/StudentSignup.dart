import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qerscan/components/Logo.dart';
import '../amjad/authscanstudent.dart';
import '../components/textform.dart';

class StudentSignUp extends StatefulWidget {
  const StudentSignUp({super.key});

  @override
  State<StudentSignUp> createState() => _StudentSignUpState();
}

class _StudentSignUpState extends State<StudentSignUp> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  final controller = Get.put(AuthServiceStudent());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'SignUp',
                    style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 5,
                  ),
                  const Text(
                    'SignUp To Continue..',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Container(
                    height: 20,
                  ),
                  Text(
                    'Username',
                    style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(height: 5,),
                  CustomTextForm(
                      hinttext: 'Enter Your Username',
                      mycontroller: username, validator: (val) {
                    if (val == "") {
                      return "Can't Be Empty";
                    }
                  }
                  ),
                  Container(
                    height: 10,
                  ),
                  Text(
                    'Email',
                    style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 5,
                  ),
                  CustomTextForm(
                      hinttext: 'Enter Your Email',
                      mycontroller: email,
                      validator: (val) {
                        if (val == "") {
                          return "Can't Be Empty";
                        }
                      }),
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
                    height: 5,
                  ),
                  CustomTextForm(
                      hinttext: 'Enter Your Password',
                      mycontroller: password, validator: (val) {
                    if (val == "") {
                      return "Can't Be Empty";
                    }
                  }),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    alignment: Alignment.topRight,
                    child: const Text(
                      'Forget Password ?',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),

            ElevatedButton( style: ButtonStyle(

              backgroundColor:
              MaterialStatePropertyAll(
                  Colors.lightBlue.shade900),

            )

            ,onPressed: ()  {
              controller.createUserWithEmailAndPassword(
                  email.text, password.text);
              setState(() {

              });
            }, child:
            controller.isLoading==true?
            const Center(
              child: CircularProgressIndicator(),
            ):const Text('SignUp',style: TextStyle(
                color: Colors.white,fontSize: 28,
                fontWeight: FontWeight.bold),)
            ),


            Container(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('StudentLogin');
              },
              child: Center(
                child: Text.rich(TextSpan(children: [
                  const TextSpan(
                    text: "Have An Account ? ",
                  ),
                  TextSpan(
                      text: "Login",
                      style: TextStyle(fontSize: 15,
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
