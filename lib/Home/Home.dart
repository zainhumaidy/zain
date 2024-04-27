import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qerscan/components/edit.dart';
import 'package:qerscan/note/viewnote.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<QueryDocumentSnapshot> data = [];

  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("categories")
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    data.addAll(querySnapshot.docs);
    print(
        '=================================================================================================================');
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[50],
          onPressed: () {
            Navigator.of(context).pushNamed("Add");
          },
          child: Icon(color: Colors.teal.shade900, Icons.add),
        ),



        appBar: AppBar(
          title: Text('Home'),
          actions: [

ElevatedButton(onPressed: (){
  Navigator.of(context).pushNamed("Filter");

    },
      style: ButtonStyle(
          backgroundColor:
          MaterialStatePropertyAll(Colors.lightBlue.shade900),
      ), child: Text(style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),"Filter"),)
         ,Container(width: 35,)   ,

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
        body: FutureBuilder(
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
                   onTap: (){
                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                         noteview(categoryid: data[i].id)));
                   }, 
                    onLongPress: () {
                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.rightSlide,
                          title: "Warning",
                          desc: ' ? ',
                          btnCancelText: "Delet",
                          btnOkText: "Edit",
                          btnCancelOnPress: () async {
                            await FirebaseFirestore.instance
                                .collection("categories")
                                .doc(data[i].id)
                                .delete();
                            Navigator.of(context).pushReplacementNamed("Home");
                          },
                          btnOkOnPress: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => edit(
                                      docid: data[i].id,
                                      oldname: data[i]['name'],
                                    )));
                          }).show();
                    },
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Image.asset(
                              "images/EH.jpg",
                              height: 100,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${data[i]['name']}"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
