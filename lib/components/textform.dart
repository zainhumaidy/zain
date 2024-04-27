import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hinttext ;
  final TextEditingController  mycontroller ;
  final String? Function(String?)? validator ;
  const CustomTextForm({super.key,required this.hinttext , required this.mycontroller, required this.validator });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: mycontroller ,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 20,
        ),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(20)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal.shade900),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
