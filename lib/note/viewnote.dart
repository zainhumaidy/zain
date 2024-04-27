import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qerscan/components/edit.dart';

import 'addnote.dart';
import 'editnote.dart';

class noteview extends StatefulWidget {
  final String categoryid;

  const noteview({super.key, required this.categoryid});

  @override
  State<noteview> createState() => _noteviewState();
}

class _noteviewState extends State<noteview> {
  List<QueryDocumentSnapshot> data = [];

  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("categories")
        .doc(widget.categoryid)
        .collection("note")
        .get();
    data.addAll(querySnapshot.docs);
    print(
        '=================================================================================================================');
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[50],
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Addnote(
                      docid: widget.categoryid,
                    )));
          },
          child: Icon(color: Colors.teal.shade900, Icons.add),
        ),
        appBar: AppBar(
          title: Text('Note'),
          actions: [
            IconButton(
                onPressed: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  googleSignIn.disconnect();
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('Login', (route) => false);
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: WillPopScope(
          child: FutureBuilder(
            future: getData(),
            builder: (c, s) {
              if (s.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return GridView.builder(
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 160),
                  itemBuilder: (context, i) {
                    return InkWell(
                      onLongPress: () {
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.warning,
                            animType: AnimType.rightSlide,
                            title: "Warning",
                            desc: 'Are You Sure of Removing ?',
                            btnCancelOnPress: () async {},
                            btnOkOnPress: () async {
                              await FirebaseFirestore.instance
                                  .collection("categories")
                                  .doc(widget.categoryid)
                                  .collection('note')
                                  .doc(data[i].id)
                                  .delete();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => noteview(categoryid: widget.categoryid)));
                            }).show();
                      },
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Editnote(
                                notedocid: data[i].id,
                                categorydocid: widget.categoryid,
                                value: data[i]['note'])));
                       },
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.all(0),
                          child: Column(
                            children: [
                              Text("${data[i]['note']}"),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
          onWillPop: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil("Home", (route) => false);
            return Future.value(false);
          },
        ));
  }
}
