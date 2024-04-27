
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QrGen extends StatefulWidget {
  const QrGen({super.key});

  @override
  State<QrGen> createState() => _QrGenState();
}

class _QrGenState extends State<QrGen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil('teLogin', (route) => false);
          }, icon:  Icon(color: Colors.teal.shade900,
              Icons.exit_to_app))
        ],




        title: Text("QR GENERATOR"),
      ),






    );
  }
}
