import 'package:flutter/material.dart';

class Participant extends StatefulWidget {
  final String rollNo;
  const Participant({super.key, required this.rollNo});

  @override
  State<Participant> createState() => _ParticipantState();
}

class _ParticipantState extends State<Participant> {
  String prs = "Absent";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                child: Column(children: [
                  Row(
                    children: [
                      Text(
                        "Roll No : ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300),
                      ),
                      Text(
                        widget.rollNo,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Name : ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300),
                      ),
                      Text(
                        "Hushraj Singh",
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
                        "Team Rocket",
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
                        prs,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          prs = prs == "Absent" ? "Present" : "Absent";
                        });
                      },
                      child: Text("Update status")),
                ]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(),
    );
  }
}
