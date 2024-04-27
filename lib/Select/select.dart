import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../amjad/authentication_repository.dart';

class Select extends StatefulWidget {
  const Select({super.key});

  @override
  State<Select> createState() => _SelectState();
}

class _SelectState extends State<Select> {
  final controller = Get.put(AuthService());
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:35),
          child: Column(children: [


            const Row(
              children: [
                Expanded(
                  child: Text(" Press To Continue The APP.",
                  style: TextStyle(fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo
                  ),

                        ),
                ),
              ],
            ),



          Container(height: 100,),
            SizedBox(
            child: SizedBox(width: 350,height: 75,
              child: ElevatedButton(  style: ButtonStyle(

                  backgroundColor:
                  MaterialStatePropertyAll(
              Colors.lightBlue.shade900),

              ),
                  onPressed: (){  Navigator.of(context).pushReplacementNamed("teLogin");},
                  child:
                controller.isLoading==true?
                const Center(
                child: CircularProgressIndicator(),
                  ):const Text('Teacher',style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                  fontWeight: FontWeight.w400,

                ),
                )),
            ),
          ),
          Container(height: 30,),

            SizedBox(
              child: SizedBox(width: 350,height: 75,
                child: ElevatedButton(  style: ButtonStyle(

                  backgroundColor:
                  MaterialStatePropertyAll(
                      Colors.lightBlue.shade900),

                ),
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed("empLogin");
                    },
                    child:
                    controller.isLoading==true?
                    const Center(
                      child: CircularProgressIndicator(),
                    ):const Text('Employee',style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,

                    ),
                    )),
              ),
            ),
          Container(height: 30,),



            SizedBox(
              child: SizedBox(width: 350,height: 75,
                child: ElevatedButton(  style: ButtonStyle(

                  backgroundColor:
                  MaterialStatePropertyAll(
                      Colors.lightBlue.shade900),

                ),
                    onPressed: (){  Navigator.of(context).pushReplacementNamed("StudentLogin");},
                    child:
                    controller.isLoading==true?
                    const Center(
                      child: CircularProgressIndicator(),
                    ):const Text('Student',style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,

                    ),
                    )),
              ),
            ),

          ],),
        ),
      ),
    );
  }
}
