import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class StudentScanQR extends StatefulWidget {
  const StudentScanQR({super.key});

  @override
  State<StudentScanQR> createState() => _StudentScanQRState();
}

class _StudentScanQRState extends State<StudentScanQR> {
  var _scanBarcodeResult; //????????????????????????????????????????????????????????????????

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      debugPrint(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcodeResult = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[50],
        onPressed: () {
          Navigator.of(context).pushNamed("Home");
        },
        child: Icon(color: Colors.teal.shade900, Icons.account_tree_outlined),
      ),
      appBar: AppBar(
        title: const Text(
          ' Scan',
          style: TextStyle(
              color: Colors.indigo, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('StudentLogin', (route) => false);
              },
              icon: Icon(color: Colors.teal.shade900, Icons.exit_to_app))
        ],
      ),
      body: Builder(
        builder: (context) => Container(
          alignment: Alignment.center,
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Container(height: 50,),
              SizedBox(width: 350,height: 75,
                child: ElevatedButton(style: ButtonStyle(

                  backgroundColor:
                  MaterialStatePropertyAll(
                      Colors.lightBlue.shade900),

                ),
                  onPressed: scanQR,
                  child: const Text('Start QR Scaning',style:TextStyle(
                      fontSize: 30,color: Colors.white),),
                ),
              ),
              Container(
                height: 100,
              ),
              Text(
                'scan result : $_scanBarcodeResult\n',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
