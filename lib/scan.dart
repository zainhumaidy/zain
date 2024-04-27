import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';




class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  State<Scan> createState() => _ScanState();

}

class _ScanState extends State<Scan> {
  var _scanBarcodeResult ;


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


        appBar: AppBar(title: const Text('Barcode Scan'),
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
