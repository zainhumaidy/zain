import 'package:flutter/material.dart';

class CustomButtonauth extends StatelessWidget {
  final void Function ()? onPressed ;
  final String title ;
  const CustomButtonauth({super.key, required this.onPressed ,required this.title});


  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 40,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.lightBlue.shade900,
      onPressed: onPressed ,
      child:  Text(
       title ,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
