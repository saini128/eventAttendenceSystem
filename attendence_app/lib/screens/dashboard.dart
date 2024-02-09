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

    //if (!_scanning) return; // Avoid multiple scan attempts
    //await Future.delayed(Duration(seconds: 2));

    // Mark that scanning is in progress
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
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ElevatedButton(
                  //   onPressed: () {
                  //     print("ScanQR");
                  //     scanQR();
                  //   },
                  //   child: Text('Scan QR', style: TextStyle(fontSize: 16)),
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Colors.blue,
                  //     onPrimary: Colors.white,
                  //     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     elevation: 3,
                  //   ),
                  // ),

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

                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) {
                  //           return browseDatabase();
                  //         },
                  //       ),
                  //     );
                  //   },
                  //   child: Column(
                  //     children: [
                  //       Card(
                  //         clipBehavior: Clip.antiAliasWithSaveLayer,
                  //         elevation: 4,
                  //         shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(8),
                  //         ),
                  //         child: Container(
                  //           height: 90,
                  //           width: 90,
                  //           child: Padding(
                  //             padding: const EdgeInsets.all(14.0),
                  //             child: Image.asset(
                  //               'assets/qr-code.png',
                  //               height: 100,
                  //               width: 100,
                  //               fit: BoxFit.contain,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Text('Scan QR!!'),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () {
                      print("ScanQR");
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return Participant(
                      //           studentID: "65c0fe396b68e5b84965310e");
                      //     },
                      //   ),
                      // );
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
                  // SizedBox(height: 10),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     print("Check Database");
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return browseDatabase();
                  //     },
                  //   ),
                  // );
                  //   },
                  //   child: Text('Check Database', style: TextStyle(fontSize: 16)),
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Colors.blue,
                  //     onPrimary: Colors.white,
                  //     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     elevation: 3,
                  //   ),
                  // ),
                  // SizedBox(height: 30),
                  // Text('Present Participants: ' +
                  //     present_participants.toString() +
                  //     '/' +
                  //     total_participants.toString()),
                  // SizedBox(height: 10),
                  // Text('Teams Entered: ' +
                  //     present_teams.toString() +
                  //     '/' +
                  //     total_teams.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
