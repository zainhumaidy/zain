import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class empscan extends StatefulWidget {
  const empscan({super.key});

  @override
  State<empscan> createState() => _empscanState();
}

class _empscanState extends State<empscan> {
  var _scanBarcodeResult; //????????????????????????????????????????????????????????????????

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.BARCODE,
    )!
        .listen((barcode) => debugPrint(barcode));
  }

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

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("studentinfo", (route) => false);
          // Add your onPressed code here!
        },
        label: Text(
          ' No ID ?',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Colors.teal.shade900),
        ),
        icon: Icon(
          Icons.person_add_alt_1,
          size: 35,
          color: Colors.lightBlue.shade900,
        ),
        backgroundColor: Colors.white,
      ),
      appBar: AppBar(
        title: const Text(' Scan'),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('empLogin', (route) => false);
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
            children: [
              SizedBox(
                width: 350,
                height: 75,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.lightBlue.shade900),
                  ),
                  onPressed: scanBarcodeNormal,
                  child: const Text(
                    'Start barcode scan',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ),
              Container(
                height: 30,
              ),
              SizedBox(
                width: 350,
                height: 75,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.lightBlue.shade900),
                  ),
                  onPressed: scanQR,
                  child: const Text(
                    'Start QR scan',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
              ),
              Container(
                height: 30,
              ),
              SizedBox(
                width: 350,
                height: 75,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.lightBlue.shade900),
                  ),
                  onPressed: startBarcodeScanStream,
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Barcode Scan Streaming",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                height: 40,
              ),
              Text(
                'Scan Result : $_scanBarcodeResult\n',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
