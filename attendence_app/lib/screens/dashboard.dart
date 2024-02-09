// import 'package:HackTU/screens/browseDatabase.dart';
import 'package:HackTU/screens/login.dart';
import 'package:HackTU/screens/participant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<void> scanQR() async {
    String barcodeScanRes;

    setState(() {});
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      if (barcodeScanRes.isEmpty) {
        print("scanning is false");
        setState(() {});
        return;
      }
      if (barcodeScanRes == '-1') {
        print('Scan cancelled');

        setState(() {});
        return;
      }
      print(barcodeScanRes);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Participant(studentID: barcodeScanRes);
          },
        ),
      );
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
      print(barcodeScanRes);
    }

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Login();
            },
          ),
        );
        return false;
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // alignment: Alignment.center,
              padding: EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/ccslogo.png',
                    height: 70,
                    width: 70,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 20),
                  Text(
                    "Welcome to Dashboard",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Container(
                      height: 250,
                      width: 250,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Image.asset(
                          'assets/hacktu.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Mark Attendence!!",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      scanQR();
                    },
                    child: Column(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            height: 80,
                            width: 80,
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Image.asset(
                                'assets/qr-code.png',
                                height: 100,
                                width: 100,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Scan QR!!'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
