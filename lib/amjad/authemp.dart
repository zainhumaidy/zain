// import 'package:eastern_sand/screens/home_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:eastern_sand/screens/welcome_screen.dart';
// import 'package:eastern_sand/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart';
//
// class AuthenticationRepository extends GetxController {
//   static AuthenticationRepository get instance => Get.find();
//
//   //varibales
//   final _auth = FirebaseAuth.instance;
//   late final Rx<User?> firebaseUser;
//
//   @override
//   void onReady() {
//     Future.delayed(const Duration(seconds: 6));
//     firebaseUser = Rx<User?>(_auth.currentUser);
//     firebaseUser.bindStream(_auth.userChanges());
//     ever(firebaseUser, _setInitialScreen);
//   }
//
//   _setInitialScreen(User? user) {
//     user == null
//         ? Get.offAll(() => const WelcomeScreen())
//         : Get.offAll(() => const HomeScreen());
//   }
//
//   Future<void> createUserWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       print('create');
//       await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       firebaseUser.value != null
//           ? Get.offAll(() => const HomeScreen())
//           : Get.offAll(() => const HomeScreen());
//     } on FirebaseAuthException catch (e) {
//       final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
//       print('FireBase Auth Exception - ${ex.message}');
//       throw ex;
//     } catch (_) {
//       const ex = SignUpWithEmailAndPasswordFailure();
//       print('Exception - ${ex.message}');
//       throw ex;
//     }
//   }
//
//   Future<void> loginUserWithEmailAndPassword(
//
//   String email, String password) async {
//     try {  print('login');
//
//     await _auth.signInWithEmailAndPassword(email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       print(e);
//     } catch (_) {}
//   }
//
//   Future<void> logout() async => await _auth.signOut();
// }
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qerscan/amjad/user_model.dart';
import 'package:qerscan/employee/employeLogin.dart';
import 'package:qerscan/employee/empsignup.dart';

import '../employee/empscan.dart';

class empAuthService extends GetxController {
  static empAuthService get instance => Get.find();
  final firebaseAuth = auth.FirebaseAuth.instance;
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  final messagesText = TextEditingController();
  bool isLoading = false;

  User? _userFormFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(user.uid, user.email);
  }

  Stream<User?>? get user {
    return firebaseAuth.authStateChanges().map(_userFormFirebase);
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    isLoading = true;
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      isLoading=false;
      Get.offAll(()=>const empscan());
      return _userFormFirebase(credential.user);
    } catch (e) {
      isLoading = false;
      Get.snackbar('error', '$e',colorText: Colors.red);
      Get.offAll(()=>const empLogin());

      throw Exception(e);
    }
  }

  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    isLoading =true;
    try{ final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    isLoading =false;
    Get.offAll(()=>const empscan());
    return _userFormFirebase(credential.user);}
    catch(e){

      isLoading =false;
      Get.snackbar('error', '$e',colorText: Colors.red);
      Get.offAll(()=>const empSignUp());
      throw Exception(e);
    }
  }

  Future<void> signOut() async {
    return await firebaseAuth.signOut();
  }
}
