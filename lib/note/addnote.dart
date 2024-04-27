import 'package:qerscan/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qerscan/components/cuostombuttonauth.dart';
import 'package:qerscan/components/customtextadd.dart';
import 'package:qerscan/note/viewnote.dart';

class Addnote extends StatefulWidget {

  final   String docid ;
  const Addnote ({super.key,required this.docid});
  @override
  State<Addnote> createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController note = TextEditingController();

  bool isLoading =false;
  addNote() async{
    CollectionReference collectionnote
    = FirebaseFirestore.instance.collection('categories').doc(widget.docid).collection("note");

    if(formState.currentState!.validate()){
      try{isLoading =true;
      setState(() {

      });
      DocumentReference response = await collectionnote.add(
          {"note": note.text });

      Navigator.of(context)
          .push(MaterialPageRoute(builder:(context)=> noteview(categoryid: widget.docid)));
      }catch(e){
        isLoading =false;
        setState(() {

        });
        print("Error $e");}}}
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    note.dispose() ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body:Form(key:formState ,
        child:isLoading? Center(child: CircularProgressIndicator(),): Column(
          children: [

            Container(padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25) ,
              child: CustomTextFormadd(hinttext: 'Enter Your Note', mycontroller: note , validator: (val){
                if (val == ""){
                  return "Can't Be Empty" ;
                }

              }),
            ),
            CustomButtonauth(onPressed:(){
              addNote();


            }, title: "Add",)

          ],
        ),
      ),
    );
  }
}
