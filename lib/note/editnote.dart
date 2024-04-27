import 'package:qerscan/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qerscan/components/cuostombuttonauth.dart';
import 'package:qerscan/components/customtextadd.dart';
import 'package:qerscan/note/viewnote.dart';

class Editnote extends StatefulWidget {
 final String value ;
  final   String notedocid ;
  final String categorydocid ;
  const Editnote ({super.key,required this.notedocid, required this.categorydocid, required this.value});
  @override
  State<Editnote> createState() => _EditnoteState();
}

class _EditnoteState extends State<Editnote> {

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController note = TextEditingController();

  bool isLoading =false;
  editnote() async{
    CollectionReference collectionnote
    = FirebaseFirestore.instance.collection('categories').doc(widget.categorydocid).collection("note");

    if(formState.currentState!.validate()){
      try{isLoading =true;
      setState(() {

      });
     await collectionnote.doc(widget.notedocid).update(
          {"note": note.text });

      Navigator.of(context)
          .push(MaterialPageRoute(builder:(context)=> noteview(categoryid: widget.categorydocid)));
      }catch(e){
        isLoading =false;
        setState(() {

        });
        print("Error $e");}}}


  @override
  void initState() {
   note.text = widget.value ;
    super.initState();
  }




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
        title: Text('Edit'),
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
              editnote();


            }, title: "Save",)

          ],
        ),
      ),
    );
  }
}
