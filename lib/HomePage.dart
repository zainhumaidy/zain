import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {


  var _scanBarcodeResult ;  //????????????????????????????????????????????????????????????????


  Future<void>  startBarcodeScanStream() async{
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.BARCODE,
    )!
        .listen((barcode) => debugPrint(barcode));
  }


  Future<void> scanQR () async{
    String barcodeScanRes ;
    try{ barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.QR,);
    debugPrint(barcodeScanRes);}
    on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if(!mounted) return;
    setState(() {
      _scanBarcodeResult = barcodeScanRes;
    });
  }


  Future<void> scanBarcodeNormal () async{
    String barcodeScanRes ;
    try{ barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.BARCODE,);
    debugPrint(barcodeScanRes);}
    on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if(!mounted) return;

    setState(() {
      _scanBarcodeResult = barcodeScanRes;
    });
  }





  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[50],  onPressed: (){
          Navigator.of(context).pushNamed("Home");
        },child: Icon(color: Colors.teal.shade900,Icons.account_tree_outlined),
        ),

        appBar: AppBar(title: const Text(' Scan'),
          actions: [
            IconButton(onPressed: ()async{
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil('Login', (route) => false);
            }, icon:  Icon(color: Colors.teal.shade900,
                Icons.exit_to_app))
          ],
        ),

        body:
        Builder(
          builder: (context)=> Container(
            alignment: Alignment.center,

            child:
            Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                ElevatedButton(onPressed: scanBarcodeNormal, child: const Text('Start barcode scan'),),

                ElevatedButton(onPressed: scanQR, child: const Text('Start QR scan'),),


                ElevatedButton(onPressed: startBarcodeScanStream, child: const Text('Star barcode scan stream'),),

                Text('scan result : $_scanBarcodeResult\n'),
              ],

            ),
          ),
        ),



      );
  }
}
