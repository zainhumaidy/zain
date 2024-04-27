import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../components/textform.dart';
import 'empscan.dart';

class StudentInfo extends StatefulWidget {
  const StudentInfo({super.key});

  @override
  State<StudentInfo> createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed("empscan");
          },
          icon: Icon(Icons.backspace_outlined),
        ),
        centerTitle: true,
        title: Text(
          "Info",
          style: TextStyle(
            fontSize: 40,
          ),
        ),

      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Provide Us With The Following Information..",
                    style:
                        TextStyle(fontSize: 25, color: Colors.lightBlue.shade900),
                  ),
                ),
              ],
            ),
            Container(
              height: 20,
            ),
        
            Text(
              'FULLNAME',
              style: TextStyle(
                  color: Colors.teal.shade900,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              height: 2,
            ),
           TextFormField(style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),
             textAlign: TextAlign.right,
               decoration: InputDecoration(
                 border: const OutlineInputBorder(
                     borderRadius:BorderRadius.all( Radius.circular(200))),)
        
           ),
        
            Container(
              height: 10,
            ),
            Text(
              'GENDER',
              style: TextStyle(
                  color: Colors.teal.shade900,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),



            Container(
              height: 2,
            ),
            TextFormField(style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),
              textAlign: TextAlign.right,
              decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderRadius:BorderRadius.all( Radius.circular(200))),)
            ),

            Container(
              height: 10,
            ),





            Text(
              'UNIVERSITY ID NUMBER',
              style: TextStyle(
                  color: Colors.teal.shade900,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              height:2,
            ),
            TextFormField(style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),
              textAlign: TextAlign.left,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderRadius:BorderRadius.all( Radius.circular(200))),)
            ),
            Container(
              height: 20,
            ),
        
            Text(
              'NUMBER PHONE',
              style: TextStyle(
                  color: Colors.teal.shade900,
                  fontSize: 20,
                  fontWeight: FontWeight.bold, ),
            ),
            Container(
              height: 2,
            ),
            TextFormField(style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),
                textAlign: TextAlign.right,
              keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderRadius:BorderRadius.all( Radius.circular(200))),)
            ),
        
            Container(
              height: 10,
            ),
          
        
        
        
          ],
        ),
      ),
    );
  }
}
