
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qerscan/components/cuostombuttonauth.dart';
import 'package:qerscan/components/customtextadd.dart';

class edit extends StatefulWidget {
  final String docid;
  final String oldname ;
  const edit({super.key, required this.docid, required this.oldname});

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  CollectionReference categories
  = FirebaseFirestore.instance.collection('categories');

  bool isLoading =false;
  editCategory() async{
    if(formState.currentState!.validate()){
      try{isLoading =true;
      setState(() {

      });
      await categories.doc(widget.docid).set({"name": name.text},
      SetOptions(merge:  true));

      Navigator.of(context)
          .pushNamedAndRemoveUntil("Home",(route)=> false);
      }catch(e){
        isLoading =false;
        setState(() {

        });
        print("Error $e");
      }

    }

  }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose();
  }


  @override
void iniState(){
    super.initState();
    name.text=widget.oldname;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body:Form(key:formState ,
        child:isLoading? Center(child: CircularProgressIndicator(),): Column(
          children: [

            Container(padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25) ,
              child: CustomTextFormadd(hinttext: 'Enter Name', mycontroller: name , validator: (val){
                if (val == ""){
                  return "Can't Be Empty" ;
                }

              }),
            ),
            CustomButtonauth(onPressed:(){
              editCategory();


            }, title: ""
                "save",)

          ],
        ),
      ),
    );
  }
}
