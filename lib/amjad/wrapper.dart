import 'package:qerscan/HomePage.dart';
import 'package:qerscan/Select/select.dart';
import 'package:qerscan/amjad/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qerscan/auth/Login.dart';
import 'package:page_transition/page_transition.dart';
import 'authentication_repository.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService =Get.put(AuthService());
    return  StreamBuilder<User?>(
        stream: authService.user,
        builder: (_,AsyncSnapshot<User?>snapshot){
      if(snapshot.connectionState == ConnectionState.active){
        final User? user =snapshot.data;
        return user== null?const Select():const HomePage();
      }
      else{
        return const Scaffold(body: Center(child: CircularProgressIndicator(),),);
      }
        });
  }
}
