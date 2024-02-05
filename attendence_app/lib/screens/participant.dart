import 'dart:convert';
// import 'dart:ffi';
import 'package:flutter/material.dart';
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
  String eror = "";
  bool dataFetched = false;
  Future<void> fetchData() async {
    final url = Uri.parse(
        'https://api.helix.ccstiet.com/api/v1/admin/hacktu/getUserdata');
    final response = await http.post(
      url,
      body:
          json.encode({'memberID': widget.studentID, 'password': 'xxxxxx@xxx'}),
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
      });
    } else {
      setState(() {
        eror = 'Failed to fetch data.';
      });
      print('Failed to fetch data. Status code: ${response.statusCode}');
    }
    dataFetched = true;
  }

  Future<void> markAbsent() async {
    final url = Uri.parse(
        'https://api.helix.ccstiet.com/api/v1/admin/hacktu/markabsent');
    final response = await http.post(
      url,
      body:
          json.encode({'memberID': widget.studentID, 'password': 'xxxxxx@xxx'}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final resp = jsonData['success'];
      print(resp);
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
  }

  Future<void> markPresent() async {
    final url = Uri.parse(
        'https://api.helix.ccstiet.com/api/v1/admin/hacktu/markpresent');
    final response = await http.post(
      url,
      body:
          json.encode({'memberID': widget.studentID, 'password': 'xxxxxx@xxx'}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final resp = jsonData['success'];
      print(resp);
      if (resp == true)
        setState(() {
          prs = true;
        });
    } else {
      setState(() {
        eror = 'Failed to fetch data.';
      });
      print('Failed to fetch data. Status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dataFetched
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Participant Details",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
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
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                              Text(
                                name,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Team Name : ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                              Text(
                                teamName,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "College : ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                              Text(
                                college,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Email : ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                              Text(
                                memberEmail,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Phone : ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                              Text(
                                memberPhone.toInt().toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Gender : ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                              Text(
                                memberGender,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Hostel : ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                              Text(
                                memberHostel,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Year : ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                              Text(
                                memberYear,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Roll : ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                              Text(
                                memberRoll.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Offline Presence Status : ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                              Text(
                                prs ? "Present" : "Absent",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
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
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                prs ? markAbsent() : markPresent();
                              });
                            },
                            child: Text("Update status"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Center(),
      bottomNavigationBar: Row(),
    );
  }
}
