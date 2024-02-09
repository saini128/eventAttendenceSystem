import 'dart:convert';
import 'dart:io';
// import 'dart:ffi';
import 'package:HackTU/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

class Participant extends StatefulWidget {
  final String studentID;

  const Participant({Key? key, required this.studentID}) : super(key: key);

  @override
  State<Participant> createState() => _ParticipantState();
}

class _ParticipantState extends State<Participant> {
  bool prs = false;
  String id = "";
  String teamID = "";
  String name = "";
  String teamName = "";
  String college = "";
  String memberEmail = "";
  double memberPhone = 0;
  String memberGender = "";
  String memberHostel = "";
  String memberYear = "";
  int memberRoll = 0;
  int tableNumber = 0;
  String tableMessage = '';
  String extentionMessage = "No Extention with Team";
  bool extentionBoard = false;
  String eror = "";

  bool dataFetched = false;
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

  Future<void> fetchData() async {
    try {
      final url = Uri.parse(
          'https://api.helix.ccstiet.com/api/v1/admin/hacktu/getUserdata');
      final response = await http.post(
        url,
        body: json
            .encode({'memberID': widget.studentID, 'password': 'xxxxxx@xxx'}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final data = jsonData['data'];
        print(data);

        setState(() {
          id = data['_id'] ?? '';
          teamID = data['teamID'] ?? '';
          name = data['memberName'] ?? '';
          teamName = data['teamName'] ?? '';
          college = data['college'] ?? '';
          memberEmail = data['memberEmail'] ?? '';
          memberPhone = data['memberPhone']?.toDouble() ?? 0.0;
          memberGender = data['memberGender'] ?? '';
          memberHostel = data['memberHostel'] ?? '';
          memberYear = data['memberYear'] ?? '';
          memberRoll = data['memberRoll'] ?? 0;
          prs = data['checkedIn'] ?? false;
          extentionBoard = data['extentionBoard'] ?? false;
        });
        if (prs) {
          markPresent();
          if (extentionBoard) {
            extentionMessage = 'Extention Allotted';
          } else {
            extentionMessage = 'No Extention with Team';
          }
          setState(() {});
        }
      } else {
        setState(() {
          eror = 'Failed to fetch data.';
        });
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } on SocketException {
      setState(() {
        eror = 'Connection error';
      });
    }
    dataFetched = true;
  }

  Future<void> markAbsent() async {
    try {
      final url = Uri.parse(
          'https://api.helix.ccstiet.com/api/v1/admin/hacktu/markabsent');
      final response = await http.post(
        url,
        body: json
            .encode({'memberID': widget.studentID, 'password': 'xxxxxx@xxx'}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final resp = jsonData['success'];
        print(resp);
        tableMessage = '';
        if (resp == true)
          setState(() {
            prs = false;
          });
      } else {
        setState(() {
          eror = 'Failed to fetch data.';
        });
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } on SocketException {
      setState(() {
        eror = 'Connection error';
      });
    }
  }

  Future<void> markPresent() async {
    try {
      final url = Uri.parse(
          'https://api.helix.ccstiet.com/api/v1/admin/hacktu/markpresent');
      final response = await http.post(
        url,
        body: json
            .encode({'memberID': widget.studentID, 'password': 'xxxxxx@xxx'}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final resp = jsonData['success'];
        final data = jsonData['data'];
        tableNumber = data['tableNumber'] ?? 0;
        print('tableNumber = ' + tableNumber.toString());
        print(resp);
        if (resp == true) {
          setState(() {
            prs = true;
            tableMessage = 'Allotted Table Number : ' + tableNumber.toString();
          });
        } else if (resp == false) {
          tableMessage = 'Allotted Table Number : ' + tableNumber.toString();
          setState(() {});
        }
      } else {
        setState(() {
          eror = 'Failed to fetch data.';
        });
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } on SocketException {
      setState(() {
        eror = 'Connection error';
      });
    }
  }

  Future<void> extentionCordTakenByTeam() async {
    try {
      final url = Uri.parse(
          'https://api.helix.ccstiet.com/api/v1/hacktu/takeExtention');
      final response = await http.post(
        url,
        body: json.encode({'teamID': teamID, 'password': 'xxxxxx@xxx'}),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.body);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final resp = jsonData['success'];

        print(resp);
        if (resp == true) {
          setState(() {
            extentionBoard = true;
            extentionMessage = 'Extention Allotted';
          });
        } else if (resp == false &&
            jsonData['message'] == "Extention Cord Taken") {
          extentionBoard = true;
          extentionMessage = 'Extention Allotted';
          setState(() {});
        }
      } else {
        setState(() {
          eror = 'Failed to fetch data.';
        });
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } on SocketException {
      setState(() {
        eror = 'Connection error';
      });
    }
  }

  Future<void> extentionCordReturned() async {
    try {
      final url = Uri.parse(
          'https://api.helix.ccstiet.com/api/v1/hacktu/returnExtention');
      final response = await http.post(
        url,
        body: json.encode({'teamID': teamID, 'password': 'xxxxxx@xxx'}),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.body);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final resp = jsonData['success'];
        // final message = jsonData['message'];
        extentionMessage = 'No Extention with Team';
        if (resp == true)
          setState(() {
            extentionMessage = 'No Extention with Team';
            extentionBoard = false;
          });
      } else {
        setState(() {
          eror = 'Failed to fetch data.';
        });
        print('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } on SocketException {
      setState(() {
        eror = 'Connection error';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Dashboard();
            },
          ),
        );
        return false;
      },
      child: Scaffold(
        body: dataFetched
            ? Stack(
                children: [
                  Positioned.fill(
                      child: Center(
                    child: Image.asset(
                      'assets/hacktu.png',
                      opacity: const AlwaysStoppedAnimation(.2),
                    ),
                  )),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 60,
                              child: Image.asset(
                                'assets/ccslogo.png',
                              ),
                            ),
                            Text(
                              "Participant Details",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50, left: 20),
                          child: Container(
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      "Name : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      "Team Name : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      teamName,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      "College : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      college,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      "Email : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      memberEmail,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      "Phone : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      memberPhone.toInt().toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      "Gender : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      memberGender,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      "Hostel : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      memberHostel,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      "Year : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      memberYear,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      "Roll : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      memberRoll.toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      "Offline Presence Status : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      prs ? "Present" : "Absent",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      eror,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: GestureDetector(
                                        onTap: () {
                                          {
                                            setState(() {
                                              prs
                                                  ? markAbsent()
                                                  : markPresent();
                                            });
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            Card(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              elevation: 4,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Container(
                                                height: 70,
                                                width: 70,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      14.0),
                                                  child: Image.asset(
                                                    'assets/check-list.png',
                                                    height: 100,
                                                    width: 100,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('Update Status'),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: GestureDetector(
                                        onTap: () {
                                          {
                                            setState(() {
                                              extentionBoard
                                                  ? extentionCordReturned()
                                                  : extentionCordTakenByTeam();
                                            });
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            Card(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              elevation: 4,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Container(
                                                height: 70,
                                                width: 70,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      14.0),
                                                  child: Image.asset(
                                                    'assets/plug.png',
                                                    height: 100,
                                                    width: 100,
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text('Extention Status'),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () {
                                        print("ScanQR");
                                        scanQR();
                                      },
                                      child: Column(
                                        children: [
                                          Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            elevation: 4,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Container(
                                              height: 70,
                                              width: 70,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(14.0),
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
                                            child: Text('Scan Next QR!!'),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      tableMessage,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      extentionMessage,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Center(),
        bottomNavigationBar: Row(),
      ),
    );
  }
}
