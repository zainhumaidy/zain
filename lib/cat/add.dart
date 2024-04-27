
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qerscan/components/cuostombuttonauth.dart';
import 'package:qerscan/components/customtextadd.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  CollectionReference categories
  = FirebaseFirestore.instance.collection('categories');

bool isLoading =false;
   addCategory() async{
if(formState.currentState!.validate()){
  try{isLoading =true;
    setState(() {

    });
    DocumentReference response = await categories.add(
      {"name": name.text, "id": FirebaseAuth.instance.currentUser!.uid});

    Navigator.of(context)
        .pushNamedAndRemoveUntil("Home",(route)=> false);
  }catch(e){
    isLoading =false;
    setState(() {

    });
    print("Error $e");}}}
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose() ;
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
          addCategory();


        }, title: "Add",)

          ],
        ),
      ),
    );
  }
}
