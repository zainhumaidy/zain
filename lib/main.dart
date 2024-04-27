import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:qerscan/Home/Home.dart';
import 'package:qerscan/Select/select.dart';
import 'package:qerscan/amjad/splashscreen.dart';
import 'package:qerscan/auth/Login.dart';
import 'package:qerscan/auth/SignUp.dart';
import 'package:qerscan/cat/add.dart';
import 'package:qerscan/employee/employeLogin.dart';
import 'package:qerscan/employee/empscan.dart';
import 'package:qerscan/employee/empsignup.dart';
import 'package:qerscan/note/Filter.dart';
import 'package:qerscan/studentscan/StudentLogin.dart';
import 'package:qerscan/studentscan/StudentSignup.dart';
import 'package:qerscan/teacher/qrdoctor.dart';
import 'package:qerscan/teacher/telogin.dart';
import 'package:qerscan/teacher/tesignuo.dart';
import 'HomePage.dart';
import 'employee/StudentInfo.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Scany());
}


class Scany extends StatefulWidget {
  const Scany({super.key});

  @override
  State<Scany> createState() => _ScanyState();
}

class _ScanyState extends State<Scany> {
  @override
  void initState() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('================================User is currently signed out!');
      } else {
        print('================================User is signed in!');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme:  ThemeData(
       appBarTheme: AppBarTheme(
         backgroundColor: Colors.grey[50],
         titleTextStyle: TextStyle(color: Colors.teal.shade900 ,
             fontSize: 22 ,fontWeight:FontWeight.bold ,),
         iconTheme: IconThemeData(color: Colors.teal.shade900),
       )

      ),
      debugShowCheckedModeBanner: false,
      home:const SplashScreen(),
      // ( FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified)
      //   ? HomePage() : Login(),
      routes: {
        "SignUp": (context) => const SignUp(),
        "Login": (context) => const Login(),
        "homepage": (context) => const HomePage(),
        "Add": (context) => const Add(),
        "Home": (context) => const Home(),

        "Filter": (context) => const Filter(),
        "Cselect": (context) => const  Select(),
        "StudentSignUp": (context) => const  StudentSignUp(),
        "StudentLogin": (context) => const  StudentLogin(),
        "empSignUp": (context) => const  empSignUp(),
        "empLogin": (context) => const  empLogin(),
        "studentinfo": (context) => const  StudentInfo(),
        "empscan": (context) => const  empscan(),
        "teLogin": (context) => const teLogin(),
        "teSignup": (context) => const teSignup(),
        " QrGen": (context) => const QrGen(),

      },
    );
  }
}
