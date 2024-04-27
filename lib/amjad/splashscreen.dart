import 'package:page_transition/page_transition.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:qerscan/amjad/wrapper.dart';
import 'package:qerscan/components/Logo.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(

      backgroundColor: Colors.white,

         splash:


            Column(
             children: <Widget>[
               Expanded(
                 child:

                 Padding(
                   padding: const EdgeInsets.only(top: 250),
                   child: ClipRRect(
                       borderRadius: BorderRadius.circular(100),
                       child: Image.asset("images/EH.jpg",filterQuality: FilterQuality.high,height: 300,width: 300,)
                   ),
                 ),


               ),
               Padding(
                 padding:  EdgeInsets.only(bottom: 250),
                 child: Text('SCAN',style: TextStyle(
                     fontWeight: FontWeight.bold,
                 fontStyle: FontStyle.italic,
                     letterSpacing: 10
                     ,
                 fontSize: 80,color: Colors.lightBlue.shade900),
                 ),
               ),
             ],
           ),


        splashIconSize: 1000,
        centered: true,
        duration: 3500,
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.fade,

        animationDuration: Duration(seconds: 1 ) ,


        nextScreen:
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if(constraints.maxWidth<600){
              return  const Wrapper();
            }
            else{
              return  const Wrapper();
            }
          },

        )

    );


  }
}
