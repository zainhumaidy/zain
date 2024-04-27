import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  List<QueryDocumentSnapshot> data = [];

  initialData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    QuerySnapshot userdata = await users.where("age", isEqualTo: 30).get();
    userdata.docs.forEach((element) {
      data.add(element);
    });
    setState(() {});
  }

  @override
  void initState() {
    initialData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            'Filter'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CollectionReference user =
              FirebaseFirestore.instance.collection('users');
        },
      ),
      body: Container(
        child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, i) {
              return Card(
                child: ListTile(
                  subtitle: Text("age : ${data[i]['age']}  "),
                  title: Text(
                    data[i]['username'],
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
