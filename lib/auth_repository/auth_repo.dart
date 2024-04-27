import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:get/get.dart';

class AuthServices extends GetxController{
  final firebaseAuth=auth.FirebaseAuth.instance;

 Future mySignUp(String email,String password)async{
      try{
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password
        );
      }
          catch(e){
        throw Exception(e);
          }
 }

}